function gcstogbqtable(gbq,datasetname,tablename,bucketname,blobname,createdisposition,writedisposition)
%GCSTOGBQTABLE copies content of a file located in Google Cloud Storage bucket into a bigquery table
%
% Input arguments expected:
%  * BigQuery client object
%  * Name of an existing BigQuery dataset
%  * Name of an existing or new destination Table located within the above dataset
%  * Bucket name of the Google Cloud Storage Bucket containing the file
%  * Bucket object or filename within the bucket (csv, parquet, newline json, avro or orc file formats are supported)
%    Note: If you have subfolder structure for organizing blobs pass folder
%    path within bucket e.g. "subfolder1/subfolder2/myfile.csv"
%  * ENUM for createDisposition (see details below)
%  * ENUM for writedisposition  (see details below)
%
% ENUMS for createdisposition
% ---------------------------
%  * CREATE_IF_NEEDED : Configures the job to create the table if it does not exist.
%
%  * CREATE_NEVER : Configures the job to fail with a not-found error if the table does not exist.
%
% ENUMS for writedisposition
% --------------------------
%  * WRITE_APPEND : Configures the job to append data to the table if it already exists.
%
%  * WRITE_EMPTY : Configures the job to fail with a duplicate error if the table already exists.
%
%  * WRITE_TRUNCATE : Configures the job to overwrite the table data if table already exists.
%

%                 (c) 2020 MathWorks, Inc.


% Create destination tableId

tableId = gcp.bigquery.TableId.of(datasetname,tablename);

% Constructing source data url

% Bucket url : gs://bucketname
bucketurl = strcat("gs://",bucketname);

% Object(file) url : gs://bucketname/myfile.csv
bloburl = strcat(bucketurl,'/',blobname);

% Detect file type with extension
splits = strsplit(blobname,'.');
extension = char(lower(splits{end}));

% Flag to check supported file format and will be used to execute next
% block of code only if value is 1
flag = 1;

% Create formatOptions based on file extension
switch extension
    case 'csv'
        formatOptions = gcp.bigquery.FormatOptions.csv;
    case 'json'
        formatOptions = gcp.bigquery.FormatOptions.json;
    case 'avro'
        formatOptions = gcp.bigquery.FormatOptions.avro;
    case 'parquet'
        formatOptions = gcp.bigquery.FormatOptions.parquet;
    case 'orc'
        formatOptions = gcp.bigquery.FormatOptions.orc;
    otherwise
        warning('Unsupported file format. Supported formats include "csv" , "avro", "orc", "parquet", "json(newline)" only.');
        flag=0;
end

if isequal(flag,1)
    %% Create configuration for a table Load Job
    % Job configuration object is "loadJobConfiguratio" constructed using a
    % Builder object "loadJobConfigurationBuilder"
    %
    % Set all configurations:
    %    *  destinationTable TableId
    %    *  sourceUri bloburl
    %    *  formatOptions based on extension
    %    *  setAutoDetect to detect source file schema (works only for csv and json)
    %    *  setCreateDisposition 'CREATE_IF_NEEDED' or 'CREATE_NEVER'
    %    *  setWriteDisposition 'WRITE_APPEND', append to existing data or 'WRITE_EMPTY', error out if
    %       table exists or  'WRITE_TRUNCATE', overwrites existing table
    
    % Create builder for load job configuration
    loadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.newBuilder(tableId,bloburl,formatOptions);
    
    % Set autodetect for csv and json
    loadJobConfigurationBuilder = loadJobConfigurationBuilder.setAutodetect(java.lang.Boolean(1));
    
    % Set createDisposition and writeDisposition for table creation if non-existent and
    % for appending existing table with new data
    createDispositionConfig = gcp.bigquery.JobInfo.CreateDisposition.valueOf(createdisposition);
    writeDispositionConfig = gcp.bigquery.JobInfo.WriteDisposition.valueOf(writedisposition);
    loadJobConfigurationBuilder = loadJobConfigurationBuilder.setWriteDisposition(writeDispositionConfig);
    loadJobConfigurationBuilder = loadJobConfigurationBuilder.setCreateDisposition(createDispositionConfig);
    
    % Build loadJobConfigurationbuilder to loadJobConfiguration
    loadJobConfiguration = loadJobConfigurationBuilder.build;
    
    % Creating Job Id
    randomJobId = gcp.bigquery.JobId.createJobId();
    jobId = gcp.bigquery.JobId.of(gbq.ProjectId,randomJobId);
    
    % Use loadJobConfiguration and jobId for creating jobInfo
    jobInfoBuilder = gcp.bigquery.JobInfo.newBuilder(loadJobConfiguration);
    jobInfoBuilder = jobInfoBuilder.setJobId(jobId);
    jobInfo = jobInfoBuilder.build;
    
    % Crete JobOption object for Job creation
    jobfield = gcp.bigquery.BigQuery.JobField.values();
    jobOption = gcp.bigquery.BigQuery.JobOption.fields(jobfield);
    
    % Job creation
    job = gbq.create(jobInfo,jobOption);
    
    %% Polling for job completion
    
    % Importing duration
    import org.threeten.bp.Duration
    
    % Creating duration of 1 sec
    d = Duration.ofSeconds(1);
    
    % Importing RetryOption
    import com.google.cloud.RetryOption
    
    % Initial retry delay of 1 sec
    initialretrydelay = javaMethod('initialRetryDelay','com.google.cloud.RetryOption',d);
    
    % Total timeout of 3 minutes
    totalTimeout = RetryOption.totalTimeout(Duration.ofMinutes(3));
    
    % Constructing all an array of all retry configurations constructed above
    retryOptionArray = javaArray('com.google.cloud.RetryOption',2);
    retryOptionArray(1) = initialretrydelay;
    retryOptionArray(2) = totalTimeout;
    
    % Execute Job wait with the retryoptions
    job.waitFor(retryOptionArray);
    
end
end



