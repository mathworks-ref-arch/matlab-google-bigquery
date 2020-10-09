# MATLAB Interface *for Google BigQuery* API documentation


## Google BigQuery Interface Objects and Methods:
* @BigQuery
* @BigQueryOptions
* @Dataset
* @DatasetId
* @DatasetInfo
* @ExternalTableDefinition
* @FormatOptions
* @Job
* @JobId
* @JobInfo
* @LoadJobConfiguration
* @Object
* @QueryJobConfiguration
* @Table
* @TableId
* @TableInfo
* @TableResult
* @WriteChannelConfiguration



------

## @BigQuery

### @BigQuery/BigQuery.m
```notalanguage
  BIGQUERY Google Big Query Client Library for MATLAB

    Documentation for gcp.bigquery.BigQuery
       doc gcp.bigquery.BigQuery




```
### @BigQuery/create.m
```notalanguage
  CREATE Method to create a bigquery dataset and job
 
  This method supports creating datasets and jobs. It does not support
  creating new bigquery table from scratch with scehma.
  Bigquery table creations are supported as a result of queries returning results into a temporary or permanent tables
 
  create() method depends on options such as `DatasetOption` and
  `JobOption` for creating datasets and jobs respectively. Find more about
  Options under +gcp/+Bigquery/
 
  Usage
 
  Create a dataset:
 
        gbq = gcp.bigquery.BigQuery("credentials.json");
        datasetId = gcp.bigquery.DatasetId.of("datasetname");
        datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);
        datasetField = gcp.bigquery.BigQuery.DatasetField.valueOf
        datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField)
        dataset = gbqclient.create(datasetInfo,datasetOption);
 
  Create a query job:
 
        gbq = gcp.bigquery.BigQuery("credentials.json");
        jobField = gcp.bigquery.BigQuery.JobField.values;
        jobOptions = gcp.bigquery.BigQuery.JobOption.fields(jobField);
        randomJobId = gcp.bigquery.JobId.createJobId();
        jobId = gcp.bigquery.JobId.of(gbq.ProjectId,randomJobId);
        query = "SELECT title, comment, contributor_ip, timestamp, num_characters FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0 LIMIT 40;";
        queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
        queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setUseLegacySql(logical(1));
        queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setAllowLargeResults(logical(1));
        queryJobConfiguration = queryJobConfigurationBuilder.build;
        jobInfo = gcp.bigquery.JobInfo.newBuilder(queryJobConfiguration).setJobId(jobId).build;
        job = gbq.create(jobInfo,jobOptions);



```
### @BigQuery/deleteDataset.m
```notalanguage
  DELETEDATASET Method to delete a dataset
    
  Usage
 
        gbq = gcp.bigquery.BigQuery()
        tf = gbq.deleteDataset('datasetid')



```
### @BigQuery/deleteTable.m
```notalanguage
  DELETETABLE Method to delete a table
 
  Usage
 
        gbq = gcp.bigquery.BigQuery()
        tf = gbq.deleteTable(TableID)



```
### @BigQuery/getDataset.m
```notalanguage
  GETDATASET Method to request a dataset
 
  This method will call the Google Big Query project configured to request
  a list of projects.
 
  Usage
 
        gbq = gcp.bigquery.BigQuery("credentials.json")
        dataSet = gbq.getDataset(datasetId); ,where datsetId is of type "gcp.bigquery.DatasetId"
           or
        dataSet = gbq.getDataset("datasetId"); , where datasetId is of type string or char



```
### @BigQuery/getJob.m
```notalanguage
  GETJOB Method to request an existing job using the jobid
 
  Usage
 
        gbq = gcp.bigquery.BigQuery("credentials.json")
        job = gbq.getJob(jobId); ,where jobId is of type "gcp.bigquery.JobId"
 
           or
 
        job = gbq.getJob("jobId"); , where jobId is of type string or char



```
### @BigQuery/getTable.m
```notalanguage
  GETTABLE Method to request an existing bigquery TABLE
 
  Usage
 
    gbq = gcp.bigquery.BigQuery("credentials.json")
    gbqtable = gbq.getTable('datasetId','tableId');



```
### @BigQuery/listDatasets.m
```notalanguage
  LISTDATASETS Method to list the project's datasets
  
  Usage:
 
    % create gbq client
    gbq = gcp.bigquery.BigQuery("credentials.json");
    
    % create options/configs for how to list datasets
    datasetListOption1 = ...
    gcp.bigquery.BigQuery.DatasetListOption.all/labelFilter/pageSize/pageToken(input);
    
    datasetList = gbq.listDatasets(datsetListOption1,....,datasetListOptionN);



```
### @BigQuery/listTables.m
```notalanguage
  LISTTABLES Method to list the tables in the dataset
 
    gbq = gcp.bigquery.BigQuery("credentials.json");
    tableList = gbq.listTables('datasetId');



```
### @BigQuery/query.m
```notalanguage
  QUERY Method to Run the query associated with the request, using an internally-generated random JobId.
 
  Usage
 
   Synchronous/Interactive jobs:
 
        smallquery = 'SELECT TOP( title, 10) as title, COUNT(*) as revision_count FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0;';
        queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(smallquery);
        queryJobConfigurationBuilder = queryJobConfigurationBuilder.setUseLegacySql(logical(1));
        queryJobConfiguration = queryJobConfigurationBuilder.build
 
        tableResult = gbq.query(queryJobConfiguration)
        table = gbq2table(tableResult)
 
 
   Asynchronous/Batch query jobs:
 
 
        query = "SELECT title, comment, contributor_ip, timestamp, num_characters FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0 LIMIT 40000;";
        queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
        queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setUseLegacySql(logical(1));
        queryJobConfigurationBuilder = queryJobConfigurationBuilder.setAllowLargeResults(logical(1));
        queryJobConfigurationBuilder = queryJobConfigurationBuilder.setDestinationTable(tableId);
        queryJobConfiguration = queryJobConfigurationBuilder.build
 
        jobInfo = gcp.bigquery.JobInfo.newBuilder(queryJobConfiguration1).setJobId(jobId).build;
        job = gbq.create(jobInfo,jobOptions)
        job.waitFor
 
        queryResultsOption = gcp.bigquery.BigQuery.QueryResultsOption.pageSize(100)
        tableResult = job.getQueryResults(queryResultsOption) 
        
    Note: Alternatively query results can be loaded to Google Cloud storage
    bucket and downloaded using ExtractJob



```

------


## @BigQueryOptions

### @BigQueryOptions/BigQueryOptions.m
```notalanguage
  BigQueryOptions A Google BigQuery Dataset.
 
 
  Usage
 
  No explicit usage. This class and it's methods are used in the process of
  creating a Bigquery client within the class Bigquery

    Documentation for gcp.bigquery.BigQueryOptions
       doc gcp.bigquery.BigQueryOptions




```

------


## @Dataset

### @Dataset/Dataset.m
```notalanguage
  DATASET A Google BigQuery Dataset.
  Objects of this class are immutable.Dataset adds a layer of service-related functionality over DatasetInfo.
   
  Usage
 
        gbq = gcp.bigquery.BigQuery("credentials.json");
        datasetId = gcp.bigquery.DatasetId.of("datasetname");
        datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);
        datasetField = gcp.bigquery.BigQuery.DatasetField.valueOf
        datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField)
        dataset = gbqclient.create(datasetInfo,datasetOption);

    Documentation for gcp.bigquery.Dataset
       doc gcp.bigquery.Dataset




```
### @Dataset/delete.m
```notalanguage
  DELETE Method - deletes current table and returns TRUE or FALSE depending
  on success of the deletion
 
   Usage
 
      tf = dataset.delete()



```
### @Dataset/exists.m
```notalanguage
  EXISTS Method - checks if current dataset exists and returns boolean
  status
 
   tf = dataset.exists()



```

------


## @DatasetId

### @DatasetId/DatasetId.m
```notalanguage
  DATASETID Google BigQuery Dataset identity.
 
  Usage:
 
    Create  a datasetid for a new dataset on BigQuery
 
      datasetId = gcp.bigquery.DatasetId.of("datasetname");
 
      gbqclient = gcp.bigquery.Bigquery(credentials.json);
      projectId = gbqclient.ProjectId;
      datasetId = gcp.bigquery.DatasetId.of(projectId,"datasetname");
 
  (c) 2020 MathWorks, Inc.

    Documentation for gcp.bigquery.DatasetId
       doc gcp.bigquery.DatasetId




```

------


## @DatasetInfo

### @DatasetInfo/DatasetInfo.m
```notalanguage
  DATASETINFO Google BigQuery Dataset information. A dataset is a grouping mechanism that holds zero or more tables.
  
  Datasets are the lowest level unit of access control.
  Google BigQuery does not allow control access at the table level.
    
  Usage
 
      gbqclient = gcp.bigquery.Bigquery(credentials.json);
      projectId = gbqclient.ProjectId;
      datasetId = gcp.bigquery.DatasetId.of(projectId,"datasetname");
 
      datasetInfoBuilder = gcp.bigquery.DatasetId.newBuilder(projectId,datasetId);
      datasetInfoBuilder = datasetInfoBuilder.setLocation("location");
      datasetInfo = datasetInfoBuilder.build();
 
    or
 
      datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);

    Documentation for gcp.bigquery.DatasetInfo
       doc gcp.bigquery.DatasetInfo




```

------


## @ExternalTableDefinition

### @ExternalTableDefinition/ExternalTableDefinition.m
```notalanguage
  EXTERNALTABLEDEFINITION Creates Table Definition using external data
  sources
    
  Usage
 
         sourceUri = "gs://bucketName/filename.csv"
         formatOptions = gcp.bigquery.FormatOptions.csv()
         
            1. ExternalTableDefinitionBuilder = gcp.bigquery.ExternalTableDefinition.newBuilder(sourceUri, formatOptions);
               ExternalTableDefinition = ExternalTableDefinitionBuilder.build();
         
            2. ExternalTableDefinition = gcp.bigquery.ExternalTableDefinition.of(sourceUri, formatOptions);

    Documentation for gcp.bigquery.ExternalTableDefinition
       doc gcp.bigquery.ExternalTableDefinition




```

------


## @FormatOptions

### @FormatOptions/FormatOptions.m
```notalanguage
  FORMATOPTIONS Base class for Google BigQuery format options. 
 
  This class defines the format of external data used by BigQuery, for either federated tables or load jobs.
  Load jobs support the following formats: AVRO, CSV, JSON, ORC, PARQUET
 
  Usage
 
  formatOptions = gcp.bigquery.FormatOptions.csv()
 
  formatOptions = gcp.bigquery.FormatOptions.json()
 
  formatOptions = gcp.bigquery.FormatOptions.avro()
 
  formatOptions = gcp.bigquery.FormatOptions.parquet()
 
  formatOptions = gcp.bigquery.FormatOptions.orc()

    Documentation for gcp.bigquery.FormatOptions
       doc gcp.bigquery.FormatOptions




```

------


## @Job

### @Job/Job.m
```notalanguage
  JOB Object to return the status of a job
 
  Create a query job:
 
        gbq = gcp.bigquery.BigQuery("credentials.json");
        jobField = gcp.bigquery.BigQuery.JobField.values;
        jobOptions = gcp.bigquery.BigQuery.JobOption.fields(jobField);
        randomJobId = gcp.bigquery.JobId.createJobId();
        jobId = gcp.bigquery.JobId.of(gbq.ProjectId,randomJobId);
        query = "SELECT title, comment, contributor_ip, timestamp, num_characters FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0 LIMIT 40;";
        queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
        queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setUseLegacySql(logical(1));
        queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setAllowLargeResults(logical(1));
        queryJobConfiguration = queryJobConfigurationBuilder.build;
        jobInfo = gcp.bigquery.JobInfo.newBuilder(queryJobConfiguration).setJobId(jobId).build;
        job = gbq.create(jobInfo,jobOptions);
 
  The create() method internally calls this class to wrap the Job into a
  MATLAB object gcp.bigquery.Job

    Documentation for gcp.bigquery.Job
       doc gcp.bigquery.Job




```
### @Job/getQueryResults.m
```notalanguage
  GETQUERYRESULTS Returns TableResults for an asynchronous query job
    
  Usage
 
        % Creating options with which Job should be created
        
        jobField = gcp.bigquery.BigQuery.JobField.values;
        jobOptions = gcp.bigquery.BigQuery.JobOption.fields(jobField);
  
        % Creating Job Id
        
        randomJobId = gcp.bigquery.JobId.createJobId();
        jobId = gcp.bigquery.JobId.of(gbq.ProjectId,randomJobId)
  
        % Setting Query configuration and Job Id to JobInfo
  
        jobInfo = gcp.bigquery.JobInfo.newBuilder(queryJobConfiguration1).setJobId(jobId).build;
  
        % Job creation
  
        job = gbq.create(jobInfo,jobOptions)
        
        % Polling for job completion
        job.waitFor
  
        % Get Query Job Results
        % Setting options for the way you would want query results to be returned
  
        queryResultsOption = gcp.bigquery.BigQuery.QueryResultsOption.pageSize(100);
  
        % Receiving query results as object TableResult
        
        tableResult = job.getQueryResults(queryResultsOption)



```
### @Job/waitFor.m
```notalanguage
  WAITFOR Blocks until this job completes its execution, either failing or succeeding.
    
        % Creating options with which Job should be created
        
        jobField = gcp.bigquery.BigQuery.JobField.values;
        jobOptions = gcp.bigquery.BigQuery.JobOption.fields(jobField);
  
        % Creating Job Id
        
        randomJobId = gcp.bigquery.JobId.createJobId();
        jobId = gcp.bigquery.JobId.of(gbq.ProjectId,randomJobId)
  
        % Setting Query configuration and Job Id to JobInfo
  
        jobInfo = gcp.bigquery.JobInfo.newBuilder(queryJobConfiguration1).setJobId(jobId).build;
  
        % Job creation
  
        job = gbq.create(jobInfo,jobOptions)
        
        % Polling for job completion
        job.waitFor
 
        % Get Query Job Results
        % Setting options for the way you would want query results to be returned
  
        queryResultsOption = gcp.bigquery.BigQuery.QueryResultsOption.pageSize(100);
  
        % Receiving query results as object TableResult
        
        tableResult = job.getQueryResults(queryResultsOption)



```

------


## @JobId

### @JobId/JobId.m
```notalanguage
  JOBID Object to return the job identifier
 
  Usage
 
       % Creating a unique and random JobId - type string
       % Is used for creating the object JobId as shown below
 
       jobIdstr = gcp.bigquery.JobId.createJobId();
 
       % Examples of creating jobId 
        
       1. jobIdBuilder = newBuilder()
          jobIdBuilder = jobIdBuilder.setLocation("location");
          jobIdBuilder = jobIdBuilder.project("projectid");
          jobId = jobIdBuilder.build;
 
       2. jobId = gcp.bigquery.JobId.of()
 
       3. jobId = gcp.bigquery.JobId.of(jobIdstr)
 
       4. jobId = gcp.bigquery.JobId.of(projectId,jobIdstr)

    Documentation for gcp.bigquery.JobId
       doc gcp.bigquery.JobId




```

------


## @JobInfo

### @JobInfo/JobInfo.m
```notalanguage
 JOBINFO Google BigQuery Job information.
    
  Jobs are objects that manage asynchronous tasks such as running queries, loading data, and exporting data.
  Use QueryJobConfiguration for a job that runs a query.
 
  Usage
 
   jobInfoBuilder = gcp.bigquery.JobInfo.newBuilder(JobQueryConfiguration)
   jobInfo = jobInfoBuilder.build()

    Documentation for gcp.bigquery.JobInfo
       doc gcp.bigquery.JobInfo




```

------


## @LoadJobConfiguration

### @LoadJobConfiguration/LoadJobConfiguration.m
```notalanguage
  LOADJOBCONFIGURATION Google BigQuery load job configuration. A load job loads data from one of several formats into a table. Data is provided as URIs that point to objects in Google Cloud Storage.
  Load job configurations have JobConfiguration.Type.LOAD type.
 
  Usage
 
    % Create builder for LoadJobConfiguration using either of the two methods
 
       LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.builder(tableId,sourceUri);
 
            or
 
       LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.newBuilder(tableId,sourceUri,formatOptions);
 
    % Return LoadJobConfiguration by either building the LoadJobConfiguration.Builder or using the of() method in this class
 
        LoadJobConfiguration = LoadJobConfigurationBuilder.build;
 
            or
 
        LoadJobConfiguration = gcp.bigquery.LoadJobConfiguration.of(tableId,sourceUri,formatOptions);

    Documentation for gcp.bigquery.LoadJobConfiguration
       doc gcp.bigquery.LoadJobConfiguration




```

------


## @Object

### @Object/Object.m
```notalanguage
  OBJECT Root object for GCP.Bigquery
 
  Copyright 2020 The MathWorks, Inc.

    Documentation for gcp.bigquery.Object
       doc gcp.bigquery.Object




```

------


## @QueryJobConfiguration

### @QueryJobConfiguration/QueryJobConfiguration.m
```notalanguage
  QUERYJOBCONFIGURATION Google BigQuery Query Job configuration. A Query Job runs a query against BigQuery data. 
    
  Usage:
  
     1. Use QueryJobConfiguration.Builder to build configuration for
        queries with custom options
 
        query = "SELECT title, comment, contributor_ip, timestamp, num_characters FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0 LIMIT 40;";
        queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
        queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setUseLegacySql(logical(1));
        queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setAllowLargeResults(logical(1));
        queryJobConfiguration = queryJobConfigurationBuilder.build()
 
     2. Use QueryJobConfiguration to set default configuration for queries
 
        query = "SELECT title, comment, contributor_ip, timestamp, num_characters FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0 LIMIT 40;";
        queryJobConfiguration =  gcp.bigquery.QueryJobConfiguration.of(query);

    Documentation for gcp.bigquery.QueryJobConfiguration
       doc gcp.bigquery.QueryJobConfiguration




```

------


## @Table

### @Table/Table.m
```notalanguage
  TABLE A Google BigQuery Table.

    Documentation for gcp.bigquery.Table
       doc gcp.bigquery.Table




```
### @Table/delete.m
```notalanguage
  DELETE Method - deletes current table
 
   tf = gbqtable.delete()



```
### @Table/exists.m
```notalanguage
  EXISTS Method - checks if current table exists
 
   tf = gbqtable.exists()



```
### @Table/extract.m
```notalanguage
  EXTRACT Method - Starts a BigQuery Job to extract the current table to the provided destination URI. Returns the started Job object.
 
   filename = "mydata.csv";
   gcsbucketname = "my_bucket";
   job = table.extract(filename, gcsbucketname);



```
### @Table/load.m
```notalanguage
  LOAD Starts a BigQuery Job to load data into the current table from the provided source URIs.
    
  For instance, loading data from Google cloud storage bucket
 
  Input Arguments:
     *  bigquery table
     *  format of the source file (See FormatOptions for more details)
     *  source Uri e.g. "gs://my_bucket/filename1.csv"
     *  Job Option



```

------


## @TableId

### @TableId/TableId.m
```notalanguage
  TABLEID Returns TableId for a BigQuery Table 
    
  Usage
 
     tableId = gcp.bigquery.Table.of("DatasetId","TableId")

    Documentation for gcp.bigquery.TableId
       doc gcp.bigquery.TableId




```

------


## @TableInfo

### @TableInfo/TableInfo.m
```notalanguage
  TABLEINFO Google BigQuery table information.
    
  Usage
    
         sourceUri = "gs://bucketName/filename.csv"
         formatOptions = gcp.bigquery.FormatOptions.csv()
         
         externalTableDefinition = gcp.bigquery.ExternalTableDefinition.of(sourceUri, formatOptions);
         tableInfo = of(tableId,externalTableDefinition)

    Documentation for gcp.bigquery.TableInfo
       doc gcp.bigquery.TableInfo




```

------


## @TableResult

### @TableResult/TableResult.m
```notalanguage
  TABLERESULT Query results from BigQuery
 
  This class is used as a holder for gbq.query() and job.getQueryResults() methods return object
  
  Usage
 
        tableResult = gbq.query(queryJobConfiguration)
 
        tableResult = job.getQueryResults(queryResultsOption)

    Documentation for gcp.bigquery.TableResult
       doc gcp.bigquery.TableResult




```

------


## @WriteChannelConfiguration

### @WriteChannelConfiguration/WriteChannelConfiguration.m
```notalanguage
  WRITECHANNELCONFIGURATION Google BigQuery Configuration for a load operation. 
 
  A load configuration can be used to load data into a table with a WriteChannel (BigQuery.writer(WriteChannelConfiguration)).
  This class is in implicit usage within the function "copyfiletobigquery"
 
  Usage
  
    % Set configurations such as formatOption and detection of format overwriting permissions
    % and others while loading data from any source to a bigquery table
 
        writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setFormatOptions(formatOptions);
        writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setAutodetect(java.lang.Boolean(1));
    
    % Settings for creating a table if none exist and overwriting/appending to a table if it already exists 
 
        createDispositionConfig = gcp.bigquery.JobInfo.CreateDisposition.valueOf(createdisposition);
        writeDispositionConfig = gcp.bigquery.JobInfo.WriteDisposition.valueOf(writedisposition);
    
    % Assign the above settings of create and write disposition to the writeChannelCongfigurationBuilder
 
        writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setCreateDisposition(createDispositionConfig);
        writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setWriteDisposition(writeDispositionConfig);
  
    % Build the above config 
 
        writeChannelConfiguration = writeChannelConfigurationBuilder.build;
 
    % Create a writer object using the above configuration
 
        writer = gbq.Handle.writer(writeChannelConfiguration.Handle);
 
    % Create channel stream for writer to write in
       
       import java.nio.channels.Channels
       stream = Channels.newOutputStream(writer);
      
    % Get file path to the local source
    
        import java.nio.file.FileSystems
        path = which(filename);
        splits = strsplit(path,filesep);
        fileartifact = splits{end};
        pathartifact = fullfile(splits{1:end-1});
        javafilepath = FileSystems.getDefault().getPath(pathartifact,fileartifact);
      
     % Run file copy job
        import java.nio.file.Files
        Files.copy(javafilepath, stream);
      
     % Close writer
        writer.close
      
      % Get Job handle for the bigquery copy job
      job = writer.getJob();

    Documentation for gcp.bigquery.WriteChannelConfiguration
       doc gcp.bigquery.WriteChannelConfiguration




```

------

## Google BigQuery Interface Related Functions:
### functions/Logger.m
```notalanguage
  Logger - Object definition for Logger
  ---------------------------------------------------------------------
  Abstract: A logger object to encapsulate logging and debugging
            messages for a MATLAB application.
 
  Syntax:
            logObj = Logger.getLogger();
 
  Logger Properties:
 
      LogFileLevel - The level of log messages that will be saved to the
      log file
 
      DisplayLevel - The level of log messages that will be displayed
      in the command window
 
      LogFile - The file name or path to the log file. If empty,
      nothing will be logged to file.
 
      Messages - Structure array containing log messages
 
  Logger Methods:
 
      clearMessages(obj) - Clears the log messages currently stored in
      the Logger object
 
      clearLogFile(obj) - Clears the log messages currently stored in
      the log file
 
      write(obj,Level,MessageText) - Writes a message to the log
 
  Examples:
      logObj = Logger.getLogger();
      write(logObj,'warning','My warning message')
 



```
### functions/copyfiletobigquery.m
```notalanguage
 COPYFILETOBIGQUERY copies any local file content to a bigquery table
 
  Input arguments expected:
   * Existing BigQuery dataset
   * Existing or new destination Table located within the above dataset
   * Filename of the local csv, parquet, new line json, avro or orc file on
     MATLAB path or fully qualified path
   * ENUM for createDisposition (see details below)
   * ENUM for writedisposition  (see details below)
 
  ENUMS for createdisposition
  ---------------------------
   * CREATE_IF_NEEDED : Configures the job to create the table if it does not exist.
 
   * CREATE_NEVER : Configures the job to fail with a not-found error if the table does not exist.
 
  ENUMS for writedisposition
  --------------------------
   * WRITE_APPEND : Configures the job to append data to the table if it already exists.
 
   * WRITE_EMPTY : Configures the job to fail with a duplicate error if the table already exists.
 
   * WRITE_TRUNCATE : Configures the job to overwrite the table data if table already exists.
 



```
### functions/gbq2table.m
```notalanguage
 GBQ2TABLE Returns bigquery tableResults formatted into a structured MATLAB table



```
### functions/gbqroot.m
```notalanguage
  GBQROOT returns location of tooling



```
### functions/gcstogbqtable.m
```notalanguage
 GCSTOGBQTABLE copies content of a file located in Google Cloud Storage bucket to a bigquery table
 
  Input arguments expected:
   * Existing BigQuery dataset
   * Existing or new destination Table located within the above dataset
   * Bucket name of the Google Cloud Storage Bucket containing the file
   * Bucket object or filename within the bucket (csv, parquet, newline json, avro or orc file formats are supported)
     Note: If you have subfolder structure for organizing blobs pass folder
     path within bucket e.g. "subfolder1/subfolder2/myfile.csv"
   * ENUM for createDisposition (see details below)
   * ENUM for writedisposition  (see details below)
 
  ENUMS for createdisposition
  ---------------------------
   * CREATE_IF_NEEDED : Configures the job to create the table if it does not exist.
 
   * CREATE_NEVER : Configures the job to fail with a not-found error if the table does not exist.
 
  ENUMS for writedisposition
  --------------------------
   * WRITE_APPEND : Configures the job to append data to the table if it already exists.
 
   * WRITE_EMPTY : Configures the job to fail with a duplicate error if the table already exists.
 
   * WRITE_TRUNCATE : Configures the job to overwrite the table data if table already exists.
 



```



------------    

[//]: # (Copyright 2020 The MathWorks, Inc.)
