classdef TableField  < gcp.bigquery.Object
% TABLEFIELD Fields of a BigQuery Table resource.
%   
% Usage
% 
%    % Creating Table fields
%      1. fields = gcp.bigquery.BigQuery.TableField.values()                  % returns all Table fields
%         Note: Use only if you have permissions for all tables within this project

%      2. fields = gcp.bigquery.BigQuery.TableField.valueOf('ID','LOCATION')  % returns selected Table fields
%
%      tableOption = gcp.bigquery.BigQuery.TableOption.fields(fields); % options for specifying table get, create and update options.
%
%
% Enum Constants for Table fields
% -------------------------------
% CREATION_TIME 
% DESCRIPTION 
% ETAG 
% EXPIRATION_TIME 
% EXTERNAL_DATA_CONFIGURATION 
% FRIENDLY_NAME 
% ID 
% LABELS 
% LAST_MODIFIED_TIME 
% LOCATION 
% NUM_BYTES 
% NUM_ROWS 
% SCHEMA 
% SELF_LINK 
% STREAMING_BUFFER 
% TABLE_REFERENCE 
% TIME_PARTITIONING 
% TYPE 
% VIEW 


%                 (c) 2020 MathWorks, Inc. 


properties
end

methods
	%% Constructor 
	function obj = TableField(varargin)
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Checking class before Handle assignment
        if ~ isa(varargin{1},'com.google.cloud.bigquery.BigQuery$TableField[]')
            write(logObj,'error','TableField Object creation failed');
        else
            % Assigning array of Tale fields to Handle
            obj.Handle = varargin{1};
        end

	end
end

methods(Static)
    % Returns an array containing all the enums
    function TableField = values()
        % Imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating TableFieldArray here. no input expected
        TableFieldJ = javaMethod('values','com.google.cloud.bigquery.BigQuery$TableField');
        
        % Wrapping into a MATLAB class object
        TableField = gcp.bigquery.BigQuery.TableField(TableFieldJ);
    end
    
     % Returns an array containing the constants of this enum type, in the order they are declared.
    function TableField = valueOf(varargin)
        % Imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating TableFieldArray
        TableFieldArrJ = javaArray('com.google.cloud.bigquery.BigQuery$TableField',nargin);
        
        for i = 1:nargin
            TableFieldJ = javaMethod('valueOf','com.google.cloud.bigquery.BigQuery$TableField',varargin{i});
            TableFieldArrJ(i) = TableFieldJ;
        end
        
        % Wrapping into a MATLAB class object
        TableField = gcp.bigquery.BigQuery.TableField(TableFieldArrJ);
    end
    
end %methods(Static)

end %class

% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/BigQuery.TableField.html
%
% Java API options
% -----------------
% static BigQuery.TableField	valueOf(String name)
% Returns the enum constant of this type with the specified name.
% 
% static BigQuery.TableField[]	values()
% Returns an array containing the constants of this enum type, in the order they are declared.