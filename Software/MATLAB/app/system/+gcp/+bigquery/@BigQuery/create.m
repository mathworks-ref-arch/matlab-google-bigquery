function result = create(gbq, varargin)
% CREATE Method to create a bigquery dataset and job
%
% This method supports creating datasets and jobs. It does not support
% creating new bigquery table from scratch with scehma.
% Bigquery table creations are supported as a result of queries returning results into a temporary or permanent tables
%
% create() method depends on options such as `DatasetOption` and
% `JobOption` for creating datasets and jobs respectively. Find more about
% Options under +gcp/+Bigquery/
%
% Usage
%
% Create a dataset:
%
%       gbq = gcp.bigquery.BigQuery("credentials.json");
%       datasetId = gcp.bigquery.DatasetId.of("datasetname");
%       datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);
%       datasetField = gcp.bigquery.BigQuery.DatasetField.valueOf
%       datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField)
%       dataset = gbqclient.create(datasetInfo,datasetOption);
%
% Create a query job:
%
%       gbq = gcp.bigquery.BigQuery("credentials.json");
%       jobField = gcp.bigquery.BigQuery.JobField.values;
%       jobOptions = gcp.bigquery.BigQuery.JobOption.fields(jobField);
%       randomJobId = gcp.bigquery.JobId.createJobId();
%       jobId = gcp.bigquery.JobId.of(gbq.ProjectId,randomJobId);
%       query = "SELECT title, comment, contributor_ip, timestamp, num_characters FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0 LIMIT 40;";
%       queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
%       queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setUseLegacySql(logical(1));
%       queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setAllowLargeResults(logical(1));
%       queryJobConfiguration = queryJobConfigurationBuilder.build;
%       jobInfo = gcp.bigquery.JobInfo.newBuilder(queryJobConfiguration).setJobId(jobId).build;
%       job = gbq.create(jobInfo,jobOptions);
%
%   Creating an empty table:
%
%   % Create Table definition:
%           StandardTableDefinitionBuilder = gcp.bigquery.StandardTableDefinition.newBuilder();
%           StandardTableDefinition = StandardTableDefinitionBuilder.build();
%   
%   % Create TableId for a table and a given dataset
%           tableId = gcp.bigquery.TableId.of("existing_dataset","new_gbq_tablename")
%
%   % Create TableInfo:
%           tableInfo = gcp.bigquery.TableInfo.of(tableId,StandardTableDefinition);
%
%   % Create TableField and TableOption
%           tableFields = gcp.bigquery.BigQuery.TableField.values
%           tableOption = gcp.bigquery.BigQuery.TableOption.fields(tableFields)
%
%   % Create a new and empty table
%           gbqclient.create(tableInfo,tableOption)

%                 (c) 2020 MathWorks, Inc.


%% Get java client for bigquery using the Handle of the MATLAB class object gbq
gbqJ = gbq.Handle;

% Access second input argument and check for class
% Switch case for classes jobInfo, TableInfo and DatasetInfo
switch(class(varargin{1}))
    case 'gcp.bigquery.JobInfo'
        jobInfo = varargin{1}.Handle;
        jobOption = varargin{2}.Handle;
        
        jobOptionArray = javaArray('com.google.cloud.bigquery.BigQuery$JobOption',1);
        jobOptionArray(1) = jobOption;
        % Creating Job
        jobj = gbqJ.create(jobInfo,jobOptionArray);
        result = gcp.bigquery.Job(jobj);
        
    case 'gcp.bigquery.TableInfo'
        tableInfo = varargin{1}.Handle;
        tableOption = varargin{2}.Handle;
        
        tableOptionArray = javaArray('com.google.cloud.bigquery.BigQuery$TableOption',1);
        tableOptionArray(1) = tableOption;
        % Empty Table
        tablej = gbqJ.create(tableInfo,tableOptionArray);
        result = gcp.bigquery.Table(tablej);
        
    case 'gcp.bigquery.DatasetInfo'
        datasetInfo = varargin{1}.Handle;
        datasetOption = varargin{2}.Handle;
        
        datasetOptionArray = javaArray('com.google.cloud.bigquery.BigQuery$DatasetOption',1);
        datasetOptionArray(1) = datasetOption;
        
        % Create dataset
        datasetj = gbqJ.create(datasetInfo,datasetOptionArray);
        result = gcp.bigquery.Dataset(datasetj);
end

end %function

%% Supported Java methods
%
% Dataset	create(DatasetInfo datasetInfo, BigQuery.DatasetOption... options)
% Creates a new dataset.
%
% Job	create(JobInfo jobInfo, BigQuery.JobOption... options)
% Creates a new job.
% 
% Table	create(TableInfo tableInfo, BigQuery.TableOption... options)
% Creates a new table.
%