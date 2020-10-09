classdef DatasetField  < gcp.bigquery.Object
% DATASETFIELD Fields of a BigQuery Dataset resource.
%   
% USAGE
%       % Will allow just DatasetId to be the field information returned 
%           datasetField = gcp.bigquery.BigQuery.DatasetField.valuesOf()
%
%       % Will allow all fields related to Dataset to be returned - 
%       % Note: Use only if you have enough access
%           datasetField = gcp.bigquery.BigQuery.DatasetField.values()

%                 (c) 2020 MathWorks, Inc. 

properties
end

methods
	%% Constructor 
	function obj = DatasetField(varargin)
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Validating class of input arguments before assigning Handle
        if ~ isa(varargin{1},'com.google.cloud.bigquery.BigQuery$DatasetField[]')
            write(logObj,'error','DatasetField Object creation failed');
        else
            obj.Handle = varargin{1};
        end

	end
end

methods(Static)
    % Returns an array containing the constants of this enum type, in the order they are declared.
    function DatasetField = values()
        % imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating DatasetFieldArray here. no input expected
        DatasetFieldJ = javaMethod('values','com.google.cloud.bigquery.BigQuery$DatasetField');
        
        % wrapping into a MATLAB class object
        DatasetField = gcp.bigquery.BigQuery.DatasetField(DatasetFieldJ);
    end
    
    function DatasetField = valuesOf()
        % imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating DatasetFieldArray here. no input expected
        DatasetFieldJ = javaMethod('valueOf','com.google.cloud.bigquery.BigQuery$DatasetField','ID');
        
        % Create an array
        DatasetFieldArrayJ = javaArray('com.google.cloud.bigquery.BigQuery$DatasetField',1);
        DatasetFieldArrayJ(1) = DatasetFieldJ;
        
        % wrapping into a MATLAB class object
        DatasetField = gcp.bigquery.BigQuery.DatasetField(DatasetFieldArrayJ);
    end
    
end%methods(Static)

end %class

% Java API Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/BigQuery.DatasetField.html
%
% Supported Methods
% -----------------
% static BigQuery.DatasetField	valueOf(String name)
% Returns the enum constant of this type with the specified name.
%
% static BigQuery.DatasetField[]	values()
% Returns an array containing the constants of this enum type, in the order they are declared.

% Enum Constants expected as fields
% ---------------------------------
% ACCESS 
% CREATION_TIME 
% DATASET_REFERENCE 
% DEFAULT_TABLE_EXPIRATION_MS 
% DESCRIPTION 
% ETAG 
% FRIENDLY_NAME 
% ID 
% LABELS 
% LAST_MODIFIED_TIME 
% LOCATION 
% SELF_LINK