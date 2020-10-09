function TableResult = query(gbq, varargin)
% QUERY Method to Run the query associated with the request, using an internally-generated random JobId.
%
% Usage
%
%  Synchronous/Interactive jobs:
%
%       smallquery = 'SELECT TOP( title, 10) as title, COUNT(*) as revision_count FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0;';
%       queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(smallquery);
%       queryJobConfigurationBuilder = queryJobConfigurationBuilder.setUseLegacySql(logical(1));
%       queryJobConfiguration = queryJobConfigurationBuilder.build
%
%       tableResult = gbq.query(queryJobConfiguration)
%       matlabtable = gbq2table(tableResult)
%
%
%  Asynchronous/Batch query jobs:
%
%
%       query = "SELECT title, comment, contributor_ip, timestamp, num_characters FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0 LIMIT 40000;";
%       queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
%       queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setUseLegacySql(logical(1));
%       queryJobConfigurationBuilder = queryJobConfigurationBuilder.setAllowLargeResults(logical(1));
%       queryJobConfigurationBuilder = queryJobConfigurationBuilder.setDestinationTable(tableId);
%       queryJobConfiguration = queryJobConfigurationBuilder.build
%
%       jobInfo = gcp.bigquery.JobInfo.newBuilder(queryJobConfiguration1).setJobId(jobId).build;
%       job = gbq.create(jobInfo,jobOptions)
%       job.waitFor
%
%       queryResultsOption = gcp.bigquery.BigQuery.QueryResultsOption.pageSize(100)
%       tableResult = job.getQueryResults(queryResultsOption) 
%       
%   Note: Alternatively query results can be loaded to Google Cloud storage
%   bucket and downloaded using ExtractJob
%       

%                 (c) 2020 MathWorks, Inc.


%% Set default Property-Value Pairs (Comment/Delete this section if not used)

% Accessing Google Big Query client Handle
gbqJ = gbq.Handle;

% Assigning queryJobconfiguration input arguments
queryJobConfiguration = varargin{1};

% Creating Job Options
JobField = gcp.bigquery.BigQuery.JobField.values;
JobOption = gcp.bigquery.BigQuery.JobOption.fields(JobField);
JobOptionArray = javaArray('com.google.cloud.bigquery.BigQuery$JobOption',1);
JobOptionArray(1) = JobOption.Handle;

% Submit query with the job options and input query job configuration
TableResultJ = gbqJ.query(queryJobConfiguration.Handle, JobOptionArray);
    
% Package Table Results into a MATLAB class object
TableResult = gcp.bigquery.TableResult(TableResultJ);

end %function
