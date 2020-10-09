function tableResult = getQueryResults(job, varargin)
% GETQUERYRESULTS Returns TableResults for an asynchronous query job
%   
% Usage
%
%       % Creating options with which Job should be created
%       
%       jobField = gcp.bigquery.BigQuery.JobField.values;
%       jobOptions = gcp.bigquery.BigQuery.JobOption.fields(jobField);
% 
%       % Creating Job Id
%       
%       randomJobId = gcp.bigquery.JobId.createJobId();
%       jobId = gcp.bigquery.JobId.of(gbq.ProjectId,randomJobId)
% 
%       % Setting Query configuration and Job Id to JobInfo
% 
%       jobInfo = gcp.bigquery.JobInfo.newBuilder(queryJobConfiguration1).setJobId(jobId).build;
% 
%       % Job creation
% 
%       job = gbq.create(jobInfo,jobOptions)
%       
%       % Polling for job completion
%       job.waitFor
% 
%       % Get Query Job Results
%       % Setting options for the way you would want query results to be returned
% 
%       queryResultsOption = gcp.bigquery.BigQuery.QueryResultsOption.pageSize(100);
% 
%       % Receiving query results as object TableResult
%       
%       tableResult = job.getQueryResults(queryResultsOption)


%                 (c) 2020 MathWorks, Inc.


%% Implementation

% Expecting input argument to be an object of type queryResultsOption
if (isa(varargin{1}.Handle,'com.google.cloud.bigquery.BigQuery$QueryResultsOption'))
    % Getting java object from Handle
     queryResultsOption = varargin{1}.Handle;
    % Creating an empty array of type QueryResultsOption and size 1
     queryResultsOptionArray = javaArray('com.google.cloud.bigquery.BigQuery$QueryResultsOption',1);
    % Assign the java object to the array at index 1
     queryResultsOptionArray(1) = queryResultsOption;
end

% Invoke the query result request to receive tableResults
tableResultJ = job.Handle.getQueryResults(queryResultsOptionArray);

% Wrap java object tableResultsJ to a MATLAB object to be returned
tableResult = gcp.bigquery.TableResult(tableResultJ);


end %function
