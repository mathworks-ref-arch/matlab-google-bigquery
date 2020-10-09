classdef Builder < gcp.bigquery.Object
%BUILDER A builder for DatasetInfo objects. 
%
%   DatasetInfo.Builder is used to set configuration for the DatasetInfo object.
%
%     datasetInfoBuilder = gcp.bigquery.DatasetInfo.newBuilder(projectId,datasetId);
%     datasetInfoBuilder = datasetInfoBuilder.setLocation("location");
%     datasetInfoBuilder = datasetInfoBuilder.setLocation(datasetId);
%     datasetInfo = datasetInfoBuilder.build();
%

%                 (c) 2020 MathWorks, Inc.
    properties
        
    end
    
    methods
        function obj = Builder(varargin)
            % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            
            % Validate builder object class before assigning the Handle
            if ~ isa(varargin{1},'com.google.cloud.bigquery.DatasetInfo$Builder')
                % Unexpected class of the input object
                write(logObj,'error','DatasetInfo.Builder object creation failed');
            else
                % Object class is as expected. Object assigned to the
                % Handle of MATLAB class object DatasetInfo.Builder
                obj.Handle = varargin{1};
            end
        end
        % sets location for datasetInfo
        function datasetInfoBuilder = setLocation(obj,location)
            
            % access datasetInfoBuilder object Handle
            datasetInfoBuilderJ = obj.Handle;
            
            % set location as a part of the builder for creating
            % datasetInfo object
            datasetInfoBuilderJ = datasetInfoBuilderJ.setLocation(location);
            
            % wrapping the Java class object datasetInfoBuilderJ to MATLAB
            % class object datasetInfoBuilder
            datasetInfoBuilder = gcp.bigquery.DatasetInfo.Builder(datasetInfoBuilderJ);
        end
        
        % sets datasetId for datasetInfo
        function datasetInfoBuilder = setDatasetId(obj,datasetId)
            
            % access datasetInfoBuilder object Handle
            datasetInfoBuilderJ = obj.Handle;
            
            % verifying class for datasetId object
            if isa(datasetId,'gcp.bigquery.DatasetId')
            
            % set datasetId as a part of the builder for creating
            % datasetInfo
                datasetInfoBuilderJ = datasetInfoBuilderJ.setDatasetId(datasetId.Handle);
            
                % wrapping the Java class object datasetInfoBuilderJ to MATLAB
                % class object datasetInfoBuilder
                datasetInfoBuilder = gcp.bigquery.DatasetInfo.Builder(datasetInfoBuilderJ);
            
            else
                warning("Expected input argument to be of class 'gcp.bigquery.DatasetId'.");
            end
        end
        
        % Building datasetInfo.Builder to return datasetInfo object
        function datasetInfo = build(obj)
            % returns datasetInfo using the build method of class
            % datasetInfo.Builder
            datasetInfoBuilderJ = obj.Handle;
            datasetInfoJ = datasetInfoBuilderJ.build;
            
            % wrapping the Java class object datasetInfoBuilderJ to MATLAB
            % class object datasetInfoBuilder
            datasetInfo = gcp.bigquery.DatasetInfo(datasetInfoJ);
        end
    end
end

%% Reference : https://googleapis.dev/java/google-cloud-bigquery/latest/com/google/cloud/bigquery/DatasetInfo.Builder.html
%
% Supported Methods
% -----------------
%
% abstract DatasetInfo	build()
% Creates a DatasetInfo object.
% 
% abstract DatasetInfo.Builder	setLocation(String location)
% Sets the geographic location where the dataset should reside.
%
% abstract DatasetInfo.Builder	setDatasetId(DatasetId datasetId)
% Sets the dataset identity.