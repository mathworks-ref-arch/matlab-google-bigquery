classdef Job < gcp.bigquery.Object
% JOB Object to return the status of a job
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
% The create() method internally calls this class to wrap the Job into a
% MATLAB object gcp.bigquery.Job

%                 (c) 2020 MathWorks, Inc.

properties
end

methods
	%% Constructor 
		
	function obj = Job(varargin)
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Verifying class of the input argument to the Dataset constructor 
        if ~ isa(varargin{1},'com.google.cloud.bigquery.Job')
            write(logObj,'error','Job Object creation failed');
        else
            obj.Handle = varargin{1};
            write(logObj,'debug','Job Handle created');
        end
	end
end

end %class