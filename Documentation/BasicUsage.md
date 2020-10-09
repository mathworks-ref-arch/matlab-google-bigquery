## Basic Usage:

This library allows one to create a table in BigQuery™ in the following manner:
* From BigQuery results
* By loading data from files
* By loading data from Google Cloud Storage™ objects

The following sections will focus on creating a BigQuery client within MATLAB and running various kinds of BigQuery jobs such as query,load etc.

### Access and query an existing BigQuery dataset

* Interactive queries : Results are expected to be small in size and will be returned as MATLAB variable of datatype ```table```.

* Batch queries : Results (number of rows) are expected to be large and will be not be returned as a MATLAB variable. Instead the interface allows results to be stored in a temporary BigQuery table. The content of this table can be downloaded to a Google Cloud Storage™ object which can be accessed through MATLAB ```Interface for Google Cloud Storage™```. See sections `Writing large query results` and `Extract query results from destination table to cloud storage bucket` on this page.

By default, BigQuery runs interactive queries, which means that the query is executed as soon as possible.
BigQuery also offers batch queries. BigQuery queues each batch query on your behalf and starts the query as soon as idle resources are available, usually within a few minutes.

At a minimum, to run a query job, you must be granted ```bigquery.jobs.create``` permissions. In order for the query job to complete successfully, you must be granted access to the datasets that contain the tables or views referenced by the query. For information on dataset access controls, see [Controlling access to datasets](https://cloud.google.com/bigquery/docs/dataset-access-controls).

#### Initializing a client

The first step is to create a client to connect to Google BigQuery Interface.
You can create a client by calling the constructor for `gcp.bigquery.BigQuery` class with or without explicitly providing your credentials as follows:
```
gbq_client = gcp.bigquery.BigQuery();
```
In the above section, the client expects to find a `credentials.json` file on path with credentials for your Google cloud account. If you wish to use different credentials, you could explicitly mention the new credentials as an input parameter to the constructor class. The credentials either need to be on MATLAB path or need to be mentioned along with their path.
```
gbq_client = gcp.bigquery.BigQuery('google-project-credentials.json');
```
#### Running interactive queries for small datasets

By default, BigQuery runs interactive (on-demand) query jobs, which means that the query is executed as soon as possible. Interactive queries count towards your concurrent rate limit and your daily limit.

Query results are always saved to either a temporary or permanent table. You can choose whether to append or overwrite data in an existing table or whether to create a new table if none exists with the same name. For more details refer [documentation](https://cloud.google.com/bigquery/docs/running-queries#queries)

You can run an interactive query with `query` method. The resultant object is of type `tableResult` native to bigquery libraries.
To extract the `tableResult` to a MATLAB `table`, use the `gbq2table` helper function.
```
% Write your query.
smallquery = 'SELECT TOP( title, 10) as title, COUNT(*) as revision_count FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0;';

% Build a configuration for running your query
queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(smallquery);
queryJobConfigurationBuilder = queryJobConfigurationBuilder.setUseLegacySql(logical(1));
queryJobConfiguration = queryJobConfigurationBuilder.build

% Run  an interactive (synchronous) query
tableResult = gbq_client.query(queryJobConfiguration)

% Extracting results to MATLAB table (* meant for small query results. Expect latency if results are larger)
mattable = gbq2table(tableResult)
```
Note: It is recommended to run batch queries for results expected to be in the order of 1000 rows or more.

#### Running batch queries for large datasets

BigQuery queues each batch query on your behalf, and starts the query as soon as idle resources are available in the BigQuery shared resource pool. This usually occurs within a few minutes. For more details refer [documentation](https://cloud.google.com/bigquery/docs/running-queries#batch)

A batch query is referred throughout it's lifecycle through a **JobId**.
`createJobId` method allows unique JobId creation for a batch job. Once a JobId is available `create()` method can be used to create the batch job for excuting the query. Finally for polling and waiting for job completion `wait()` method can be used.

Here is an example of building a query and a query job:
```
% Write your query. Be mindful of query size and SQL/SQL Legacy type.
query = "SELECT title, comment, contributor_ip, timestamp, num_characters FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0 LIMIT 40000;";

% Use Query configuration Builder to set all parameters such as
%    * Query string
%    * Query type - such as Legacy SQL
%    * Job Priority - Interactive/Batch
queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setUseLegacySql(logical(1));

% Creating options with which Job should be created
jobField = gcp.bigquery.BigQuery.JobField.values;
jobOptions = gcp.bigquery.BigQuery.JobOption.fields(jobField);

% Creating Job Id
randomJobId = gcp.bigquery.JobId.createJobId();
jobId = gcp.bigquery.JobId.of(gbq_client.ProjectId,randomJobId)

% Setting Query configuration and Job Id to JobInfo
jobInfo = gcp.bigquery.JobInfo.newBuilder(queryJobConfiguration).setJobId(jobId).build;

% Job creation
job = gbq_client.create(jobInfo,jobOptions)

% Polling for job completion
job.waitFor

% Setting options for the way you would want query results to be returned
queryResultsOption = gcp.bigquery.BigQuery.QueryResultsOption.pageSize(100);

% Receiving query results as object TableResult (Java datatype)
tableResult = job.getQueryResults(queryResultsOption)
```

#### Writing large query results to a BigQuery table

Normally, queries have a maximum response size. If you plan to run a query that might return larger results, you can:
* In standard SQL, specify a destination table for the query results.
* In legacy SQL, specify a destination table and set the allowLargeResults option.
When you specify a destination table for large query results, you are charged for storing the data.
For more details refer [documentation](https://cloud.google.com/bigquery/docs/writing-results#writing_large_results_using_legacy_sql)

In the following section `create()` method is used to create a destination dataset to house the destination table for query results. `setDestinationTable()` method of `queryJobconfiguration` object allows a user to set a `TableId` for the destination table.

Here is an example for setting the destination table and dataset using a queryConfigurationBuilder object:
```
% Use Query configuration Builder to set all parameters such as
%    * Query string
%    * Query type - such as Legacy SQL
%    * Job Priority - Interactive/Batch
%    * Destination TableId and DatasetId - for Permanent storage

queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setUseLegacySql(logical(1));
queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setAllowLargeResults(logical(1));

% If storing result in a permanent table within a dataset on cloud. Make sure the dataset name you are passing is of an existing dataset. A table name you provide can be of a non-
% existent Table within the given dataset.

datasetname = 'newdataset1';

% Create a datasetId
projectid = gbq_client.ProjectId;
datasetId = gcp.bigquery.DatasetId.of(projectid,datasetname);

% Create datasetInfo
datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);

% Create dataset fields for listing
datasetField = gcp.bigquery.BigQuery.DatasetField.valuesOf;

% Create datasetOptions with the fields
datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField);

% Create a new dataset in your project
dataSet = gbq_client.create(datasetInfo,datasetOption);

% Creating a tableId for a destination Table within dataset
tableId = gcp.bigquery.TableId.of(datasetname,'newtable1');

% Set destination table within a dataset for storing query results permanently
queryJobConfigurationBuilder = queryJobConfigurationBuilder.setDestinationTable(tableId);

% Build again
queryJobConfiguration = queryJobConfigurationBuilder.build();

% Creating options with which Job should be created
jobField = gcp.bigquery.BigQuery.JobField.values;
jobOptions = gcp.bigquery.BigQuery.JobOption.fields(jobField);

% Creating Job Id
randomJobId = gcp.bigquery.JobId.createJobId();
jobId = gcp.bigquery.JobId.of(gbq_client.ProjectId,randomJobId);

% Setting Query configuration and Job Id to JobInfo
jobInfo = gcp.bigquery.JobInfo.newBuilder(queryJobConfiguration).setJobId(jobId).build;

% Job creation
job = gbq_client.create(jobInfo,jobOptions)

% Polling for job completion
job.waitFor
```
This query job will write the results to the BigQuery table we set as the destination table while building the QueryJobConfiguration.
To extract the results from this destination BigQuery Table into a file, see the next section on `Extract query results`.

#### Limitations
In legacy SQL, writing large results is subject to these limitations:
* You must specify a destination table.
* You cannot specify a top-level ORDER BY, TOP or LIMIT clause. Doing so negates the benefit of using allowLargeResults, because the query output can no longer be computed in parallel.
* Window functions can return large query results only if used in conjunction with a PARTITION BY clause.

#### Extract query results from destination table to cloud storage bucket

You can export table data by submitting an extract job via the client. Refer [documentation](https://cloud.google.com/bigquery/docs/exporting-data) for more details. BigQuery supports the CSV, JSON and Avro	formats for data exports.

Note: There are some [export limitations](https://cloud.google.com/bigquery/docs/exporting-data#export_limitations)
* You cannot export table data to a local file, to Sheets, or to Drive. The only supported export location is Cloud Storage.
* You can export up to 1 GB of table data to a single file. If you are exporting more than 1 GB of data, use a wildcard to export the data into multiple files. When you export data to multiple files, the size of the files will vary.
* You cannot export nested and repeated data in CSV format. Nested and repeated data is supported for Avro and JSON exports.
* When you export data in JSON format, INT64 (integer) data types are encoded as JSON strings to preserve 64-bit precision when the data is read by other systems.
* You cannot export data from multiple tables in a single export job.

In the following section `getTable` provides the handle for the destination table and `extract` method triggers the export from table to cloud storage.

Here is an example of initializing the Google Cloud Storage™ interface for accessing BigQuery table contents:
```
% Getting a handle for an existing BigQuery table
gbqtable = gbq_client.getTable(datasetname,'newtable1');

% Destination file(blob) name expected to be created on Cloud Storage with query results
filename = "tableresult.csv";

% Set Google Cloud Storage Libraries on path
run('matlab-google-cloud-storage/Software/MATLAB/startup')

% Create a Google Cloud Storage client (Authentication steps performed for Bigquery package take care of Cloud Storage package)
% Note: Make sure the set of credentials have Google Cloud Storage API enabled and the required permissions to write to a Bucket
gcstorage = gcp.storage.Storage('credentials.json');   

% Bucket name of an existing bucket on Google Cloud Storage
% Optional step : If bucket does not exist create one as shown below
bucketname = uniquebucketname;

% Create bucketInfo and bucketTargetOptions since they are required for
% bucket creation by Google Cloud Storage API
bucketInfo = gcp.storage.BucketInfo.of(uniquebucketname);
bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(gcstorage.projectId);

% Creating bucket
bucket = gcstorage.create(bucketInfo, bucketTargetOption);

% Extract Table data to a Blob Object within the Google Cloud Storage Bucket
gbqtable.extract(filename,bucketname)

% Extract results as a bulk from Cloud Storage to a local path/folder

% Get MATLAB handle for the Blob object
blobfields = gcp.storage.Storage.BlobField;
blobGetOption = gcp.storage.Storage.BlobGetOption.fields(blobfields);
blob = gcstorage.get(bucketname,filename,blobGetOption)

% Download content
localdownloadpath = "any/local/directory"
blob.downloadTo(localdownloadpath)
```

#### Freeing up resources on cloud

If not in use, you may want to delete resources to avoid paying for them.
The following section demonstrates deletion of blob, bucket, table and dataset.
Each ```delete``` execution returns a boolean representing success or failure of the deletion.
You can also choose to use ```exists``` to check for existence of any resource.

```
% Create BlobId which is an identifier for the object
blobId = gcp.storage.BlobId.of(bucketname,blob.name);

% Delete Cloud Storage Blob to empty the Bucket
tf = gcstorage.deleteObject(blobId);

% Create BucketSourceOption object to help Bucket deletion
bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(gcstorage.projectId);

% Delete Cloud Storage Bucket
tf = gcstorage.deleteObject(bucketname, bucketSourceOption);

% Delete the BigQuery Table
tf = gbqtable.delete;

% Delete BigQuery dataset
tf = dataSet.delete();

```

### Creating a BigQuery table by loading data from a file

When you load data into BigQuery, you can load data into a new table, or you can append data to an existing table, or you can overwrite a table or partition. You do not need to create an empty table before loading data into it. 
You can create the new table and load your data at the same time. When you load data into BigQuery, you can use schema auto-detection.

The library uses classes `WriteChannelConfiguration` and `WriteChannelConfiguration.Builder` to configure the Bigquery job for writing file data into a BigQuery table.
* For loading data and creating table at the same time `CREATE_DISPOSITON` should be set to `CREATE_IF_NEEDED`
* For appending data to an existing table `WRITE_DISPOSITION` should be set to `WRITE_APPEND`
* For overwriting an existing table `WRITE_DISPOSITION` should be set to `WRITE_TRUNCATE`

The builtin function `copyfiletobigquery` allows you to perform the copy/write job.

```
% Create a client
gbq_client = gcp.bigquery.BigQuery();
         
% Table names for destination tables e.g. files of format csv, parquet and json
csvtablename = 'csvnewtable';
parquettablename = 'parquetnewtable';
jsontablename = 'jsonnewtable';

% Creating a BigQuery Table while Loading data from a file            
csvfilename  = 'airlinesmall_1.csv';

% Setting ENUMS CREATE_DISPOSITION and WRITTE_DISPOSITION
createdisposition = 'CREATE_IF_NEEDED';
writedisposition = 'WRITE_TRUNCATE';

% Using function copyfiletobigquery to load contents of the csv file to a not formerly existing BigQuery table
% Note: Make sure you have the dataset created before invoking the function below

copyfiletobigquery(gbq_client,datasetname,csvtablename,csvfilename,createdisposition,writedisposition);

% To append data to an existing BigQuery Table switch WRITE_DISPOSITION to 'WRITE_APPEND'
writedisposition = 'WRITE_APPEND';
copyfiletobigquery(gbq_client,datasetname,csvtablename,csvfilename,createdisposition,writedisposition);

% Similarly for parquet file upload
% Select CREATE_DISPOSITION and WRITE_DISPOSITION appropriately
parquetfilename = 'outages.parquet';
copyfiletobigquery(gbq_client,datasetname,parquettablename,parquetfilename,createdisposition,writedisposition);

% Similarly for json file upload
% Select CREATE_DISPOSITION and WRITE_DISPOSITION appropriately
jsonfilename = 'states.json';
copyfiletobigquery(gbq_client,datasetname,jsontablename,jsonfilename,createdisposition,writedisposition);
```

#### Limitations

Loading data into BigQuery is subject to the some limitations, depending on the location and format of the source data:

[Limitations on loading local files](https://cloud.google.com/bigquery/docs/loading-data-local#limitations)
[CSV limitations](https://cloud.google.com/bigquery/docs/loading-data-cloud-storage-csv#limitations)
[JSON limitations](https://cloud.google.com/bigquery/docs/loading-data-cloud-storage-json#limitations)
[Limitations on nested and repeated data](https://cloud.google.com/bigquery/docs/nested-repeated#limitations)

### Loading data from Google Cloud Storage

When you load data from Cloud Storage into BigQuery, your data can be in any of the following formats:

* Comma-separated values (CSV)
* JSON (newline-delimited)
* Avro
* Parquet
* ORC

Recurring loads from Cloud Storage into BigQuery are supported by the BigQuery Data Transfer Service.

BigQuery supports loading data from any of the following Cloud Storage storage classes:

* Standard
* Nearline
* Coldline
* Archive

When you choose a location for your data, consider colocating Cloud Storage buckets for loading data. If your BigQuery dataset is in a multi-regional location, the Cloud Storage bucket containing the data you're loading must be in a regional or multi-regional bucket in the same location. For example, if your BigQuery dataset is in the EU, the Cloud Storage bucket must be in a regional or multi-regional bucket in the EU.
If your dataset is in a regional location, your Cloud Storage bucket must be a regional bucket in the same location. For example, if your dataset is in the Tokyo region, your Cloud Storage bucket must be a regional bucket in Tokyo.

`Exception`: If your dataset is in the US multi-regional location, you can load data from a Cloud Storage bucket in any regional or multi-regional location.
https://cloud.google.com/bigquery/docs/loading-data-cloud-storage#overview

Once you have a Google Cloud Storage Bucket ready and available, you can follow the [documentation for retrieving Cloud Storage URI](https://cloud.google.com/bigquery/external-data-cloud-storage#gcs-uri).
BigQuery does not support source URIs that include multiple consecutive slashes after the initial double slash. Cloud Storage object names can contain multiple consecutive slash ("/") characters. However, BigQuery converts multiple consecutive slashes into a single slash.

You can query an external data source to load data into a permanent table or a temporary table. Visit [Bigquery documentation](https://cloud.google.com/bigquery/external-data-cloud-storage#table-types) more details. 

Here is an example of loading contents of a Google Cloud Storage object into a permanent BigQuery table. The library uses classes `LoadJobConfiguration` and `LoadJobConfiguration.Builder` to configure the Bigquery job for writing file data into a BigQuery table. The builtin function `gcstogbqtable` allows you to perform the load job.
```
% Create a client
gbq_client = gcp.bigquery.BigQuery();

% Create a dataset (Follow steps in Query Job section)

% Defining load job destination
csvtablename = "gbqcsvtable";
parquettablename = "gbqparquettable";
jsontablename = "gbqjsontable";

% Datasource information - Bucket and Objects(Blobs)
uniquebucketname = "existingCloudStorageBucket";
csvblobname = "filename.csv";
parquetblobname = "filename.parquet";
jsonblobname = "filename.json";

% Create variables containing Source URIs
csvsourceUri = strcat("gs://", uniquebucketname, '/', csvblobname);
parquetsourceUri = strcat("gs://", uniquebucketname, '/', parquetblobname);
jsonsourceUri =  strcat("gs://", uniquebucketname, '/', jsonblobname);

% Creating a table if one does not exist during the load job and allowing append if one exists
createdisposition = 'CREATE_IF_NEEDED';
writedisposition = 'WRITE_APPEND';

% Loading csv blob content 
gcstogbqtable(gbq_client,datasetname,csvtablename,uniquebucketname,csvblobname,createdisposition,writedisposition);

% Loading parquet blob content
gcstogbqtable(gbq_client,datasetname,parquettablename,uniquebucketname,parquetblobname,createdisposition,writedisposition);

% Loading JSON blob content
gcstogbqtable(gbq_client,datasetname,jsontablename,uniquebucketname,jsonblobname,createdisposition,writedisposition);

```

#### BigQuery permissions
At a minimum, the following permissions are required to load data into BigQuery. These permissions are required if you are loading data into a new table or partition, or if you are appending or overwriting a table or partition.

* bigquery.tables.create
* bigquery.tables.updateData
* bigquery.jobs.create

#### Cloud Storage permissions
To load data from a Cloud Storage bucket, you must be granted storage.objects.get permissions. If you are using a URI wildcard, you must also have storage.objects.list permissions. The predefined Cloud IAM role storage.objectViewer can be granted to provide both:

* storage.objects.get 
* storage.objects.list

[//]: #  (Copyright 2020 The MathWorks, Inc.)
