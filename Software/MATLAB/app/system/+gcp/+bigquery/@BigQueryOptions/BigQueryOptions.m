classdef BigQueryOptions  < gcp.bigquery.Object
% BigQueryOptions Google BigQueryOptions for building a BigQuery client
%
%
% Usage
%
% No explicit usage. This class and it's methods are used in the process of
% creating a Bigquery client within the class Bigquery
    
    
%                 (c) 2020 MathWorks, Inc.
    
    
    properties
    end
    
    methods
        %% Constructor
        function obj = BigQueryOptions(varargin)
            % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            
            if ~ isa(varargin{1},'com.google.cloud.bigquery.BigQueryOptions')
                write(logObj,'error','BigQueryOptions class object creation failed');
            else
                obj.Handle = varargin{1};
            end
        end
        
        function bigQueryOptionsBuilder = newBuilder(obj)
            if ~ isa(obj.Handle,'com.google.cloud.bigquery.BigQueryOptions')
                write(logObj,'error','BigQueryOptions class object expected as input argument to newBuilder()');
            else
                bigQueryOptionsJ = obj.Handle;
                bigQueryOptionsBuilder = bigQueryOptionsJ.newBuilder();
                bigQueryOptionsBuilder = gcp.bigquery.BigQueryOptions.Builder(bigQueryOptionsBuilder);
            end
        end
        
    end
    
    methods (Static)
       
        function bigQueryOptions = getDefaultInstance()
            % Implementing GBQ client
            import com.google.cloud.bigquery.BigQuery;
            import com.google.cloud.bigquery.BigQueryOptions;
            
            % Setting Logger for gbq
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GCS';
            
            % Looking for JVM locally and verifying whether current MATLAB version is supported
            if ~usejava('jvm')
                write(logObj,'error','MATLAB must be used with the JVM enabled');
            end
            if verLessThan('matlab','9.4') % R2018a
                write(logObj,'error','MATLAB Release 2018a or newer is required');
            end
            % Use the BigQueryOptions.getDefaultInstance() function to use the default authentication options.
            gbqOptionsJ = BigQueryOptions.getDefaultInstance();
            
            bigQueryOptions = gcp.bigquery.BigQueryOptions(gbqOptionsJ);
        end
    end
    
end %class

% Reference API: https://googleapis.dev/java/google-cloud-bigquery/latest/com/google/cloud/bigquery/BigQueryOptions.html
%
%
% static com.google.cloud.http.HttpTransportOptions	getDefaultHttpTransportOptions()
%
% static BigQueryOptions	getDefaultInstance()
%
% static BigQueryOptions.Builder	newBuilder()
%
