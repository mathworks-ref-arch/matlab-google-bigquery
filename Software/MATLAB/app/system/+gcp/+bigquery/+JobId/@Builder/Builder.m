classdef Builder < gcp.bigquery.Object
%BUILDER A builder for JobId objects.
%
%   JobId.Builder is used to set configuration and jobId.
%
% Usage (implicitly used by +gcp/+bigquery/@JobId)
%
%           jobIdBuilder = gcp.bigquery.JobId.newBuilder()
%           jobIdBuilder = jobIdBuilder.setLocation('US');
%           jobId = jobIdBuilder.build()
%

%                 (c) 2020 MathWorks, Inc.
    properties
        
    end
    
    methods
        function obj = Builder(varargin)
            % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            
            if ~ isa(varargin{1},'com.google.cloud.bigquery.JobId$Builder')
                write(logObj,'error','JobId.Builder Object creation failed');
            else
                obj.Handle = varargin{1};
            end
        end
        
        function jobIdBuilder = setJob(obj,jobId)
            % set jobId as a part of the builder for creating jobId
            % jobId is of type "string"
            jobIdBuilder = obj.Handle;
            jobIdBuilder = jobIdBuilder.setJob(jobId);
            jobIdBuilder = gcp.bigquery.JobId.Builder(jobIdBuilder);
        end
        
        function jobIdBuilder = setLocation(obj,location)
            % set location as a part of the builder for creating job
            % location is of type "string"
            jobIdBuilder = obj.Handle;
            jobIdBuilder = jobIdBuilder.setLocation(location);
            jobIdBuilder = gcp.bigquery.JobId.Builder(jobIdBuilder);
        end
        
        function jobIdBuilder = setProject(obj,projectid)
            % set project as a part of the builder for creating job
            % projectid is of type "string"
            jobIdBuilder = obj.Handle;
            jobIdBuilder = jobIdBuilder.setLocation(projectid);
            jobIdBuilder = gcp.bigquery.JobId.Builder(jobIdBuilder);
        end
        
        function jobIdBuilder =	setRandomJob(obj)
            % setJob to a pseudo-random string.
            jobIdBuilder = obj.Handle;
            jobIdBuilder = jobIdBuilder.setRandomJob();
            jobIdBuilder = gcp.bigquery.JobId.Builder(jobIdBuilder);
        end
        
        function jobId = build(obj)
            % returns jobId using the build method of class
            % jobId.Builder
            jobIdBuilder = obj.Handle;
            jobId = jobIdBuilder.build;
            jobId = gcp.bigquery.JobId(jobId);
        end
    end
end

%% Reference : https://googleapis.dev/java/google-cloud-bigquery/latest/com/google/cloud/bigquery/JobId.Builder.html
%
% Supported Methods
% -----------------
%
% abstract JobId	build()
%
% abstract JobId.Builder	setJob(String job) 
% 
% abstract JobId.Builder	setLocation(String location) 
% 
% abstract JobId.Builder	setProject(String project) 
%
% JobId.Builder	setRandomJob()
% setJob to a pseudo-random string.