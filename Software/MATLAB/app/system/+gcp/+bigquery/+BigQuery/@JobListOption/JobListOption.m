classdef JobListOption  < gcp.bigquery.Object
% JOBLISTOPTION Class for specifying job list options.
%   
% Usage
%
%   gbq = gcp.bigquery.Bigquery('credentials.json');
%
%   JobListOption	= gcp.bigquery.BigQuery.JobListOption.pageSize(pageSize)
%   
%   JobListOption	 = gcp.bigquery.BigQuery.JobListOption.pageToken(pageToken)
%
%   JobListOption	= gcp.bigquery.BigQuery.JobListOption.parentJobId(parentJobId)
%
%   jobLists = gbq.listJobs(JobListOption1,JobListOption2,...,...,JobListOptionN);

%                 (c) 2020 MathWorks, Inc. 

properties
end

methods
	%% Constructor 
	function obj = JobListOption(varargin)
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Validating class of input object before handle assignment
        if ~ isa(varargin{1},'com.google.cloud.bigquery.BigQuery$JobListOption')
            write(logObj,'error','JobListOption Object creation failed');
        else
            obj.Handle = varargin{1};
        end
	end
end

methods(Static)

%Returns an option to specify the maximum number of jobs returned per page.
function JobListOption	= pageSize(pageSize)
    % imports
    import com.google.cloud.bigquery.BigQuery;
    
    % Creating JobListOption. Expecting input to be of type long
    JobListOptionJ = javaMethod('pageSize','com.google.cloud.bigquery.BigQuery$JobListOption',pageSize);
    
    % wrapping into a MATLAB class object
    JobListOption = gcp.bigquery.BigQuery.JobListOption(JobListOptionJ);

end

%Returns an option to specify the page token from which to start listing jobs.
function JobListOption	 = pageToken(pageToken)
    
    % imports
    import com.google.cloud.bigquery.BigQuery;
    
    % Creating JobListOption. Expecting input to be of type string
    JobListOptionJ = javaMethod('pageToken','com.google.cloud.bigquery.BigQuery$JobListOption',pageToken);
    
    % wrapping into a MATLAB class object
    JobListOption = gcp.bigquery.BigQuery.JobListOption(JobListOptionJ);

end

%Returns an option to list only child job from specify parent job id.
function JobListOption	= parentJobId(parentJobId)
    
    % imports
    import com.google.cloud.bigquery.BigQuery;
    
    % Creating JobListOption. Expecting input to be of type string
    JobListOptionJ = javaMethod('parentJobId','com.google.cloud.bigquery.BigQuery$JobListOption',parentJobId);
    
    % wrapping into a MATLAB class object
    JobListOption = gcp.bigquery.BigQuery.JobListOption(JobListOptionJ);

end


end %methods(Static)

end %class

% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/BigQuery.JobListOption.html
%
% Java API options
% -------------------
%
% Supported Methods
% -------------------
% static BigQuery.JobListOption	pageSize(long pageSize)
% Returns an option to specify the maximum number of jobs returned per page.
%
% static BigQuery.JobListOption	pageToken(String pageToken)
% Returns an option to specify the page token from which to start listing jobs.
%
% static BigQuery.JobListOption	parentJobId(String parentJobId)
% Returns an option to list only child job from specify parent job id.
%
% Unsupported Methods
% -------------------
% static BigQuery.JobListOption	allUsers()
% Returns an option to list all jobs, even the ones issued by other users.
%
% static BigQuery.JobListOption	fields(BigQuery.JobField... fields)
% Returns an option to specify the job's fields to be returned by the RPC call.
%
% static BigQuery.JobListOption	maxCreationTime(long maxCreationTime)
% Returns an option to filter out jobs after the given maximum creation time.
%
% static BigQuery.JobListOption	minCreationTime(long minCreationTime)
% Returns an option to filter out jobs before the given minimum creation time.
%
% static BigQuery.JobListOption	stateFilter(JobStatus.State... stateFilters)
% Returns an option to list only jobs that match the provided state filters.