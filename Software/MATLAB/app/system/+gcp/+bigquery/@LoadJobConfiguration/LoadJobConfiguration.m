classdef LoadJobConfiguration  < gcp.bigquery.Object
% LOADJOBCONFIGURATION Google BigQuery load job configuration. A load job loads data from one of several formats into a table. Data is provided as URIs that point to objects in Google Cloud Storage.
% Load job configurations have JobConfiguration.Type.LOAD type.
%
% Usage
%
%   % Create builder for LoadJobConfiguration using either of the two methods
%
%      LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.builder(tableId,sourceUri);
%
%           or
%
%      LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.newBuilder(tableId,sourceUri,formatOptions);
%
%   % Return LoadJobConfiguration by either building the LoadJobConfiguration.Builder or using the of() method in this class
%
%       LoadJobConfiguration = LoadJobConfigurationBuilder.build;
%
%           or
%
%       LoadJobConfiguration = gcp.bigquery.LoadJobConfiguration.of(tableId,sourceUri,formatOptions);
%

%                 (c) 2020 MathWorks, Inc.

    
    properties
    end
    
    methods
        %% Constructor
        function obj = LoadJobConfiguration(varargin)
            % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            
            switch (class(varargin{1}))
                case 'com.google.cloud.bigquery.LoadJobConfiguration'
                    obj.Handle = varargin{1};
                otherwise
                    write(logObj,'error','LoadJobConfiguration Object creation failed');
            end
            
        end
    end
    
    methods (Static)
        
        % Creates a builder for a BigQuery Load Job configuration given the destination table and source URI.
        % Both inputs are of string datatype: 'tablename' and 'gs:\\bucketname\blobname'
        function LoadJobConfigurationBuilder = builder(tableId,sourceUri)
                           
                % tableId is of class com.google.bigquery.TableId
                % sourceUri is a string bucket url
                % create configuration for load job
                LoadJobConfigurationBuilderJ = javaMethod('builder','com.google.cloud.bigquery.LoadJobConfiguration',tableId.Handle,sourceUri);
                LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.Builder(LoadJobConfigurationBuilderJ);
         
        end
        
        % Creates a builder for a BigQuery Load Job configuration given the destination table and source URIs.
        function LoadJobConfigurationBuilder = newBuilder(varargin)
            if isequal(nargin,2)
                % tableId is of class com.google.bigquery.TableId
                tableId = varargin{1}.Handle;
                % sourceUri is a string bucket url
                sourceUri = varargin{2};
                % create configuration for load job
                LoadJobConfigurationBuilderJ = javaMethod('newBuilder','com.google.cloud.bigquery.LoadJobConfiguration',tableId,sourceUri);
                LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.Builder(LoadJobConfigurationBuilderJ);
            elseif isequal(nargin,3)
                % tableId is of class com.google.bigquery.TableId
                tableId = varargin{1}.Handle;
                % formatOption based on file extension on cloud storage
                formatOptions = varargin{3}.Handle;
                % sourceUri is a string bucket url
                sourceUri = varargin{2};
                % create configuration for load job
                LoadJobConfigurationBuilderJ = javaMethod('newBuilder','com.google.cloud.bigquery.LoadJobConfiguration',tableId,sourceUri,formatOptions);
                LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.Builder(LoadJobConfigurationBuilderJ);
            else
                warning('Incorrect number of input arguments');
            end
        end
        
        % Returns a BigQuery Load Job Configuration for the given destination table, format Option and source URI
        function LoadJobConfiguration = of(varargin)
            if isequal(nargin,2)
                % tableId is of class com.google.bigquery.TableId
                tableId = varargin{1}.Handle;
                % sourceUri is a string bucket url
                sourceUri = varargin{2};
                % create configuration for load job
                LoadJobConfigurationJ = javaMethod('of','com.google.cloud.bigquery.LoadJobConfiguration',tableId,sourceUri);
                LoadJobConfiguration = gcp.bigquery.LoadJobConfiguration(LoadJobConfigurationJ);
            elseif isequal(nargin,3)
                % tableId is of class com.google.bigquery.TableId
                tableId = varargin{1}.Handle;
                % sourceUri is a string bucket url
                sourceUri = varargin{2};
                % formatOption based on file extension on cloud storage
                formatOptions = varargin{3}.Handle;
                % create configuration for load job
                LoadJobConfigurationJ = javaMethod('of','com.google.cloud.bigquery.LoadJobConfiguration',tableId,sourceUri,formatOptions);
                LoadJobConfiguration = gcp.bigquery.LoadJobConfiguration(LoadJobConfigurationJ);
            else
                warning('Incorrect number of input arguments');
            end
        end
        
    end %methods (Static)
    
end %class

% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/LoadJobConfiguration.html
%
%% Supported Java APIs
% --------------------
% static LoadJobConfiguration.Builder	builder(TableId destinationTable, String sourceUri)
% Creates a builder for a BigQuery Load Job configuration given the destination table and source URI.
%
% static LoadJobConfiguration.Builder	newBuilder(TableId destinationTable, String sourceUri)
% Creates a builder for a BigQuery Load Job configuration given the destination table and source URI.
%
% static LoadJobConfiguration.Builder	newBuilder(TableId destinationTable, String sourceUri, FormatOptions format)
% Creates a builder for a BigQuery Load Job configuration given the destination table, format and source URI.
%
% static LoadJobConfiguration	of(TableId destinationTable, String sourceUri)
% Returns a BigQuery Load Job Configuration for the given destination table and source URI.
%
% static LoadJobConfiguration	of(TableId destinationTable, String sourceUri, FormatOptions format)
% Returns a BigQuery Load Job Configuration for the given destination table, format and source URI.

%% Unsupported Java APIs
% --------------------
% static LoadJobConfiguration.Builder	newBuilder(TableId destinationTable, List<String> sourceUris)
% Creates a builder for a BigQuery Load Job configuration given the destination table and source URIs.
%
% static LoadJobConfiguration.Builder	newBuilder(TableId destinationTable, List<String> sourceUris, FormatOptions format)
% Creates a builder for a BigQuery Load Job configuration given the destination table, format and source URIs.
%
% static LoadJobConfiguration	of(TableId destinationTable, List<String> sourceUris)
% Returns a BigQuery Load Job Configuration for the given destination table and source URIs.
%
% static LoadJobConfiguration	of(TableId destinationTable, List<String> sourceUris, FormatOptions format)
% Returns a BigQuery Load Job Configuration for the given destination table, format and source URI.