classdef DatasetInfo  < gcp.bigquery.Object
% DATASETINFO Google BigQuery Dataset information. 
% 
% A dataset is a grouping mechanism that holds zero or more tables.
% Datasets are the lowest level unit of access control.
% Google BigQuery does not allow control access at the table level.
%   
% Usage
%
%     gbqclient = gcp.bigquery.Bigquery('credentials.json');
%     projectId = gbqclient.ProjectId;
%     datasetId = gcp.bigquery.DatasetId.of(projectId,"datasetname");
%
%     datasetInfoBuilder = gcp.bigquery.DatasetId.newBuilder(projectId,datasetId);
%     datasetInfoBuilder = datasetInfoBuilder.setLocation("location");
%     datasetInfo = datasetInfoBuilder.build();
%
%   or
%
%     datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);


%                 (c) 2020 MathWorks, Inc. 


properties
end

methods
	%% Constructor 
	function obj = DatasetInfo(varargin)
        % Wraps DatasetInfo java object to a MATLAB object 
        
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Constructor checks for the expected java class object 
        if ~ isa(varargin{1},'com.google.cloud.bigquery.DatasetInfo')
            % Log error if class is different
            write(logObj,'error','DatasetInfo Object creation failed');
        else
            % If received object is of the expected class, assign it to the
            % class Handle for DatasetInfo
            obj.Handle = varargin{1};
        end

	end
end

methods(Static)
    
    % Creates a datasetInfo based on datasetId only
    function datasetInfo = of(varargin)
        % This method takes datasetId as input and returns a datasetInfo
        % object
        
        % imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Expecting DatasetId as an input argument
        % Single input argument expected
        if ~isequal(numel(varargin),1)
            write(logObj,'error','Unexpected number of inputs')
        elseif isa(varargin{1},'string') || isa(varargin{1},'char')
            datasetid = string(varargin{1}.Handle);
        elseif isa(varargin{1},'gcp.bigquery.DatasetId')
            datasetid = varargin{1}.Handle;
        else
            write(logObj,'error','Unexpected class for input argument')
        end
        % Create a DatasetInfo, with datasetId
        datasetInfoJ = javaMethod('of','com.google.cloud.bigquery.DatasetInfo',datasetid);
        
        % wrapping into a MATLAB class object
        datasetInfo = gcp.bigquery.DatasetInfo(datasetInfoJ);
        
    end % function
    
    % Allows user to add input configurations for using a Builder object to
    % create datasetInfo
    function datasetInfoBuilder = newBuilder(varargin)
        if nargin==1
            datasetId = varargin{1};
            switch class(datasetId)
                case 'string'
                    % Building datasetInfo.Builder object with just
                    % datasetId of type string
                    datasetInfoBuilderJ = javaMethod('newBuilder','com.google.cloud.bigquery.DatasetInfo',datasetId);
                    % wrapping java Object into a MATLAB class Object DatasetInfo.Builder
                    datasetInfoBuilder = gcp.bigquery.DatasetInfo.Builder(datasetInfoBuilderJ);
                case 'char'
                    % Building datasetInfo.Builder object with just
                    % datasetId of type char
                    datasetInfoBuilderJ = javaMethod('newBuilder','com.google.cloud.bigquery.DatasetInfo',datasetId);
                    % wrapping java Object into a MATLAB class Object DatasetInfo.Builder
                    datasetInfoBuilder = gcp.bigquery.DatasetInfo.Builder(datasetInfoBuilderJ);
                case 'gcp.bigquery.DatasetId'
                    % Building datasetInfo.Builder object with just
                    % datasetId of type gcp.bigquery.DatasetId
                    datasetInfoBuilderJ = javaMethod('newBuilder','com.google.cloud.bigquery.DatasetInfo',datasetId.Handle);
                    % wrapping java Object into a MATLAB class Object DatasetInfo.Builder
                    datasetInfoBuilder = gcp.bigquery.DatasetInfo.Builder(datasetInfoBuilderJ);
                otherwise
                    warning("Unexpected datatype for input argument datasetId")
            end
        elseif nargin==2
            projectId = varargin{1}; %string
            datasetId = varargin{2}; %string
            % Building datasetInfo.Builder object with projectId and
            % datasetId
            datasetInfoBuilderJ = javaMethod('newBuilder','com.google.cloud.bigquery.DatasetInfo',projectId,datasetId);
            % Wrapping java Object into a MATLAB class Object DatasetInfo.Builder
            datasetInfoBuilder = gcp.bigquery.DatasetInfo.Builder(datasetInfoBuilderJ);
        else
            warning("Incorrect number of input arguments");
        end
    end % function

end % methods(Static)

end %class

%%
% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/DatasetInfo.html
%
% Java API - Supported methods
%
% static DatasetInfo	of(DatasetId datasetId)
% Returns a DatasetInfo object given it's identity.
% 
% static DatasetInfo	of(String datasetId)
% Returns a DatasetInfo object given it's user-defined id.
% 
% static DatasetInfo.Builder	newBuilder(DatasetId datasetId)
% Returns a builder for a DatasetInfo object given it's identity.
% 
% static DatasetInfo.Builder	newBuilder(String datasetId)
% Returns a builder for a DatasetInfo object given it's user-defined id.
% 
% static DatasetInfo.Builder	newBuilder(String projectId, String datasetId)
% Returns a builder for the DatasetInfo object given it's user-defined project and dataset ids.