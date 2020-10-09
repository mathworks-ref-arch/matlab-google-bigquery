classdef DatasetId  < gcp.bigquery.Object
    % DATASETID Google BigQuery Dataset identity.
    %
    % Usage:
    %
    %   Create  a datasetid for a new dataset on BigQuery
    %
    %     gbqclient = gcp.bigquery.Bigquery(credentials.json);
    %     projectId = gbqclient.ProjectId;
    %
    %     1. datasetId = gcp.bigquery.DatasetId.of("datasetname");
    %     2. datasetId = gcp.bigquery.DatasetId.of(projectId,"datasetname");
    %
    % (c) 2020 MathWorks, Inc.
    
    properties
    end
    
    methods
        %% Constructor
        
        function obj = DatasetId(varargin)
            
            % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            
            % Check for DatasetId object class before assigning Handle
            if ~ isa(varargin{1},'com.google.cloud.bigquery.DatasetId')
                write(logObj,'error','DatasetId Object creation failed');
            else
                % Assign java object DatasetId to Handle for MATLAB class
                % object gcp.bigquery.DatasetId
                obj.Handle = varargin{1};
            end
        end
    end
    
    methods(Static)
        function datasetId = of(varargin)
            % imports
            import com.google.cloud.bigquery.BigQuery;
            
            % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            
            % Switch case to implement multiple methods based on number and
            % type of input arguments
            switch numel(varargin)
                case 1
                    % Expecting single input argument to be the datsetId
                    dataset = varargin{1};
                    if ~isa(varargin{1},'string') && ~isa(varargin{1},'char')
                        write(logObj,'error','Expected input argument to be a dataset name in string format');
                    else
                        % Create a DatasetId, with string name of dataset
                        datasetIdJ = javaMethod('of','com.google.cloud.bigquery.DatasetId',dataset);
                        
                        % wrapping into a MATLAB class object gcp.bigquery.DatasetId using
                        % the above constructor
                        datasetId = gcp.bigquery.DatasetId(datasetIdJ);
                    end
                    
                case 2
                    % Expecting 2 input arguments to be the datsetId and
                    % projectid
                    projectid = varargin{1};
                    dataset = varargin{2};
                    if ~isa(varargin{1},'string') && ~isa(varargin{1},'char')
                        write(logObj,'error','Expected input argument to be a dataset name in string format');
                    else
                        % Create a DatasetId, with projectid and datasetname - both
                        % of type string
                        datasetIdJ = javaMethod('of','com.google.cloud.bigquery.DatasetId',projectid,dataset);
                        
                        % wrapping into a MATLAB class object gcp.bigquery.DatasetId using
                        % the above constructor
                        datasetId = gcp.bigquery.DatasetId(datasetIdJ);
                    end
                    
                otherwise
                    write(logObj,'error','Unexpected number of inputs')
                    
            end %switch
            
        end % function
        
    end % methods(Static)
    
end %class
%
% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/DatasetId.html
%
% Java API - Supported methods
%
% static DatasetId	of(String dataset)
% Creates a dataset identity given only its user-defined id.
%
% static DatasetId	of(String project, String dataset)
% Creates a dataset identity given project's and dataset's user-defined ids.