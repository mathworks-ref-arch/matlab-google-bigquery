classdef StandardTableDefinition  < gcp.bigquery.Object
% STANDARDTABLEDEFINITION Creates Table Definition for creating tables
% without Schema
%   
% Usage
%
%   Example: Creating an empty table
%   --------------------------------
%
%   % Create Table definition:
%           StandardTableDefinitionBuilder = gcp.bigquery.StandardTableDefinition.newBuilder();
%           StandardTableDefinition = StandardTableDefinitionBuilder.build();
%   
%   % Create TableId for a table and a given dataset
%           tableId = gcp.bigquery.TableId.of("existing_dataset","new_gbq_tablename")
%
%   % Create TableInfo:
%           tableInfo = gcp.bigquery.TableInfo.of(tableId,StandardTableDefinition);
%
%   % Create TableField and TableOption
%           tableFields = gcp.bigquery.BigQuery.TableField.values
%           tableOption = gcp.bigquery.BigQuery.TableOption.fields(tableFields)
%
%   % Create a new and empty table
%           gbqclient.create(tableInfo,tableOption)

%                 (c) 2020 MathWorks, Inc. 

properties
end

methods
	%% Constructor 
	function obj = StandardTableDefinition(varargin)
       
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Verifying object class before assigning the Handle
        if ~ isa(varargin{1},'com.google.cloud.bigquery.StandardTableDefinition')
            write(logObj,'error','StandardTableDefinition Object creation failed due to invalid class');
        else
            % Assigning java class object
            % 'com.google.cloud.bigquery.StandardTableDefinition' as a
            % Handle for MATLAB object gcp.bigquery.StandardTableDefinition
            obj.Handle = varargin{1};
        end
	end
end

methods (Static)
    
    % Creating Builder for StandardTableDefinition class object
    function StandardTableDefinitionBuilder = newBuilder(varargin)
        
        if isequal(nargin,0)
            % Expecting 0 input arguments for an empty table definition
            
            % Creating Builder object
            StandardTableDefinitionBuilderJ = javaMethod('newBuilder','com.google.cloud.bigquery.StandardTableDefinition');
            
            % Wrapping Java class object StandardTableDefinitionBuilderJ
            % into a MATLAB class object StandardTableDefinitionBuilder
            % using constructor
            StandardTableDefinitionBuilder = gcp.bigquery.StandardTableDefinition.Builder(StandardTableDefinitionBuilderJ);
          else
            warning('Incorrect number of input arguments. Currently newBuilder method accepts 0 arguments for building an empty table definition');
        end
    end
    
     
end

end %class

% Reference : https://googleapis.dev/java/google-cloud-bigquery/latest/com/google/cloud/bigquery/StandardTableDefinition.html
%
% Supported Java APIs
% -------------------
% static StandardTableDefinition.Builder	newBuilder()
% Creates a builder for an StandardTableDefinition object.

