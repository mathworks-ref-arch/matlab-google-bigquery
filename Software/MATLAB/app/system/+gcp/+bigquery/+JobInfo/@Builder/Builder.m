classdef Builder < gcp.bigquery.Object
%BUILDER A builder for JobInfo objects.
%
%   JobInfo.Builder is used to set configuration and jobId for the JobInfo object.
%
% Usage (implicitly used by +gcp/+bigquery/@JobInfo)
%
%           jobInfoBuilder = gcp.bigquery.JobInfo.newBuilder(QueryJobConfiguration)
%           jobInfoBuilder = jobInfoBuilder.setJobId(jobId);
%           jobInfo = jobInfoBuilder.build();
%

%                 (c) 2020 MathWorks, Inc.
    properties
        
    end
    
    methods
        function obj = Builder(varargin)
            % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            
            % Verify class of the input object before assigning the Handle
            if ~ isa(varargin{1},'com.google.cloud.bigquery.JobInfo$Builder')
                write(logObj,'error','JobInfo.Builder Object creation failed');
            else
                obj.Handle = varargin{1};
            end
        end
        
        function jobInfoBuilder = setJobId(obj,jobId)
            % set jobId as a part of the builder for creating jobInfo
            jobInfoBuilder = obj.Handle;
            jobInfoBuilder = jobInfoBuilder.setJobId(jobId.Handle);
            jobInfoBuilder = gcp.bigquery.JobInfo.Builder(jobInfoBuilder);
        end
        
        function jobInfo = build(obj)
            % returns jobInfo using the build method of class
            % jobInfo.Builder
            jobInfoBuilder = obj.Handle;
            jobInfo = jobInfoBuilder.build;
            jobInfo = gcp.bigquery.JobInfo(jobInfo);
        end
    end
end

%% Reference : https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/JobInfo.Builder.html
%
% Supported Methods
% -----------------
%
% abstract JobInfo	build()
% Creates a JobInfo object.
% 
% abstract JobInfo.Builder	setJobId(JobId jobId)
% Sets the job identity.
%
% Unsupported Methods:
% -------------------
% abstract JobInfo.Builder	setConfiguration(JobConfiguration configuration)
% Sets a configuration for the JobInfo object.