classdef Builder < gcp.bigquery.Object
%BUILDER A builder for BigQueryOptions
%
%   BigQueryOptions.Builder is used to set configuration for BigQuery client object.
%
%           
%           bigqueryOptionsBuilder = gcp.bigquery.BigQueryOptions.Builder()      

%

%                 (c) 2020 MathWorks, Inc.
    properties
        
    end
    
    methods
        function obj = Builder(varargin)
            % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            
            if ~ isa(varargin{1},'com.google.cloud.bigquery.BigQueryOptions$Builder')
                write(logObj,'error','BigQueryOptions.Builder Object creation failed');
            else
                obj.Handle = varargin{1};
            end
        end
        
        function BigQueryOptionsBuilder = setLocation(obj,location)
            % set location for the BigQueryOptions builder object for
            % creating BigQuery client
            BigQueryOptionsBuilder = obj.Handle;
            BigQueryOptionsBuilder = BigQueryOptionsBuilder.setLocation(location);
            BigQueryOptionsBuilder = gcp.bigquery.BigQueryOptions.Builder(BigQueryOptionsBuilder);
        end
        
        function BigQueryOptionsBuilder = setCredentials(obj,credentials)
            % set credentials for gcp client for the BigQueryOptions builder object for
            % creating BigQuery client
            BigQueryOptionsBuilder = obj.Handle;
            BigQueryOptionsBuilder = BigQueryOptionsBuilder.setCredentials(credentials);
            BigQueryOptionsBuilder = gcp.bigquery.BigQueryOptions.Builder(BigQueryOptionsBuilder);
        end
        
        function BigQueryOptionsBuilder = setProjectId(obj,projectId)
            % set projectId of the Google Cloud project for the BigQueryOptions builder object for
            % creating BigQuery client
            BigQueryOptionsBuilder = obj.Handle;
            BigQueryOptionsBuilder = BigQueryOptionsBuilder.setProjectId(projectId);
            BigQueryOptionsBuilder = gcp.bigquery.BigQueryOptions.Builder(BigQueryOptionsBuilder);
        end
        function bigQueryOptions = build(obj)
            % returns BigQueryOptions using the build method of class
            % BigQueryOptions.Builder
            bigQueryOptionsBuilder= obj.Handle;
            bigQueryOptions= bigQueryOptionsBuilder.build;
            bigQueryOptions = gcp.bigquery.BigQueryOptions(bigQueryOptions);
        end
    end
end

%% Reference : https://googleapis.dev/java/google-cloud-bigquery/latest/com/google/cloud/bigquery/BigQueryOptions.Builder.html
%
% Supported Methods
% -----------------
%
% BigQueryOptions	build() 
% 
% BigQueryOptions.Builder	setLocation(String location) 
% 
% BigQueryOptions.Builder	setCredentials(GoogleCredentials credentials) 
% 
% BigQueryOptions.Builder	setProjectId(String ProjectId) 