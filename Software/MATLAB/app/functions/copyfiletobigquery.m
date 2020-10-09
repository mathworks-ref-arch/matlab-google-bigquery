function copyfiletobigquery(gbq,datasetname,tablename,filename,createdisposition,writedisposition)
%COPYFILETOBIGQUERY copies any local file content into a bigquery table
%
% Input arguments expected:
%  * Bigquery client object
%  * Name of an existing BigQuery dataset
%  * Name of an existing or new destination Table located within the above dataset
%  * Filename of the locally available csv, parquet, new line json, avro or orc file on
%    MATLAB path or fully qualified path
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

%% Create destination tableId for copying content into
% datasetname is the name of an existing dataset
% tablename is the name of a new or existing destination table
tableId = gcp.bigquery.TableId.of(datasetname,tablename);

%% Creating writer channel for copying file content

% Detect file type with extension
splits = strsplit(filename,'.');
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
    %% Set all configurations for a Bigquery File Copy Job:
    % Job configuration object is "writechannelConfiguration" constructed using a
    % Builder object "writeChannelConfigurationBuilder"
    %
    % Set of configurations:
    %    *  destination TableId
    %    *  formatOptions based on extension
    %    *  setAutoDetect to detect source file schema
    %    *  setCreateDisposition 'CREATE_IF_NEEDED' or 'CREATE_NEVER'
    %    *  setWriteDisposition 'WRITE_APPEND', append to existing data or 'WRITE_EMPTY', error out if
    %       table exists or  'WRITE_TRUNCATE', overwrites existing table
    
    % Destination tableId is set
    writeChannelConfigurationBuilder = gcp.bigquery.WriteChannelConfiguration.newBuilder(tableId);
    
    % Format option based on file extension is set and autodetected
    writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setFormatOptions(formatOptions);
    writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setAutodetect(java.lang.Boolean(1));
    
    % Create and Write disposition settings configured
    createDispositionConfig = gcp.bigquery.JobInfo.CreateDisposition.valueOf(createdisposition);
    writeDispositionConfig = gcp.bigquery.JobInfo.WriteDisposition.valueOf(writedisposition);
    writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setCreateDisposition(createDispositionConfig);
    writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setWriteDisposition(writeDispositionConfig);
    writeChannelConfiguration = writeChannelConfigurationBuilder.build;
        
    %% Create table writer
    writer = gbq.Handle.writer(writeChannelConfiguration.Handle);
    
    % Create channel stream for writer to write in
    import java.nio.channels.Channels
    stream = Channels.newOutputStream(writer);
    
    % Get file path to the local source
    import java.nio.file.FileSystems
    path = which(filename);
    pathartifact = strrep(path,strcat(filesep,filename),'');
    javafilepath = FileSystems.getDefault().getPath(pathartifact,filename);
    
    % Run file copy job
    import java.nio.file.Files
    Files.copy(javafilepath, stream);
    
    % Close writer
    writer.close
    
    % Get Job handle for the bigquery copy job
    job = writer.getJob();
    
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
% exit function no return value
end

