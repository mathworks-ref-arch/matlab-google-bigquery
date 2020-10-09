classdef Builder < gcp.bigquery.Object
%BUILDER A builder for StandardTableDefinition objects.
%
%   StandardTableDefinition.Builder is used to set configuration for
%   writing data to BigQuery Tables
%   
%
% Usage (implicitly used by +gcp/+bigquery/@StandardTableDefinition)
%
%  StandardTableDefinitionBuilder = gcp.bigquery.BigQuery.newBuilder();
%  StandardTableDefinition = StandardTableDefinitionBuilder.build;
%

%                 (c) 2020 MathWorks, Inc.
    properties
        
    end
    
    methods
        function obj = Builder(varargin)
            % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            
            % Verify class of the input java class object before
            % wrapping/assigning it as a Handle for MATLAB class object
            % gcp.bigquery.StandardTableDefinition.Builder
            if ~ isa(varargin{1},'com.google.cloud.bigquery.StandardTableDefinition$Builder')
                write(logObj,'error','StandardTableDefinition.Builder Object creation failed');
            else
                % Assigning Handle
                obj.Handle = varargin{1};
            end
        end
        
        % Creates an StandardTableDefinition object by calling build() on the builder
        % object
        function StandardTableDefinition = build(obj)
            % Accessing builder using the class handle
            StandardTableDefinitionBuilderJ = obj.Handle;
            % Building Table Definition
            StandardTableDefinitionJ = StandardTableDefinitionBuilderJ.build;
            
            % Wrapping Java object StandardTableDefinitionJ to MATLAB class
            % object StandardTableDefinition using constructor
            StandardTableDefinition = gcp.bigquery.StandardTableDefinition(StandardTableDefinitionJ);
        end
        
    end % methods
end % class

% Java Reference API : https://googleapis.dev/java/google-cloud-bigquery/latest/com/google/cloud/bigquery/StandardTableDefinition.Builder.html
% -------------------
%
% Supported Methods:
% ------------------
% abstract StandardTableDefinition	build()
% Creates an StandardTTableDefinition object.

