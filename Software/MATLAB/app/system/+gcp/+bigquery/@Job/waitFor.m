function waitFor(job, varargin)
% WAITFOR Blocks until this job completes its execution, either failing or succeeding.
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


%% Set default Property-Value Pairs (Comment/Delete this section if not used)
%
import com.google.cloud.RetryOption;

jobJ = job.Handle;

% This class represents an options wrapper around the RetrySettings class and is an alternative way of initializing it. The retry options are usually provided in a form of varargs for methods that wait for changes in the status of a resource, 
% do poll operations or retry on failures.
%
% Ref: https://googleapis.dev/java/google-cloud-clients/0.103.0-alpha/com/google/cloud/RetryOption.html

% Creating a config for RetryAttempts
retryOption = javaMethod('maxAttempts','com.google.cloud.RetryOption',100);

% Creating an array of configs for job retry
retryOptionArray = javaArray('com.google.cloud.RetryOption',1);

% Assign retryattemps as an option in the array of retry options
retryOptionArray(1) = retryOption;

% wait for the Job with the given retry options array
jobJ = jobJ.waitFor(retryOptionArray);

% poll for job status
status = jobJ.getStatus;

% flag for a successful job
flag = false;

% check if status has an error field with error message
% If the error field is not empty set the flag to true
if ~isempty(status.getError)
    fprintf("\n");
    status.getError
    flag=true; % flag for errored job
end
if ~isempty(status.getExecutionErrors)
    fprintf("\n");
    status.getExecutionErrors
    flag=true; % flag for errored job
end
% If flag==false , there are no errors in this completed job
if(~flag)
if isequal("DONE",string(jobJ.getStatus.getState.toString()))
    fprintf("\nJob completed\n");
end
end
end %function
