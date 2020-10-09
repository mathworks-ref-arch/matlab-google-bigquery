classdef JobInfo < gcp.bigquery.Object
%JOBINFO Google BigQuery Job information.
%   
% Jobs are objects that manage asynchronous tasks such as running queries, loading data, and exporting data.
% Use QueryJobConfiguration for a job that runs a query.
%
% Usage
%
%  jobInfoBuilder = gcp.bigquery.JobInfo.newBuilder(QueryJobConfiguration)
%  jobInfo = jobInfoBuilder.build()

%                 (c) 2020 MathWorks, Inc.
    properties
        
    end
    
    methods
        function obj = JobInfo(varargin)
            % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            % Verify input class object and assigning Handle
            if ~ (isa(varargin{1},'com.google.cloud.bigquery.JobInfo'))
                write(logObj,'error','JobInfo object creation failed');
            else
                obj.Handle = varargin{1};
            end
        end
        
    end
    
   methods(Static)
       
       function jobInfoBuilder = newBuilder(QueryJobConfiguration)
           
           % Returns a builder for a JobInfo object given the job configuration.
           jobInfoBuilder = javaMethod('newBuilder','com.google.cloud.bigquery.JobInfo',QueryJobConfiguration.Handle);
           
           % Wrap object into MATLAB class using the above constructor
           jobInfoBuilder = gcp.bigquery.JobInfo.Builder(jobInfoBuilder);
       end
   end
end

%%
% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/JobInfo.html
%
% Java API - Supported methods
% 
% static JobInfo.Builder	newBuilder(JobConfiguration configuration)
% Returns a builder for a JobInfo object given the job configuration.