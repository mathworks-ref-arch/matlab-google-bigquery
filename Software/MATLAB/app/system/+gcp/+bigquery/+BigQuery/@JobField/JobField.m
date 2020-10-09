classdef JobField  < gcp.bigquery.Object
% JOBFIELD Fields of a BigQuery Job resource.
%   
% Usage
%
%  Returns a JobField array containing JobFields in the order they are declared
%
%           1. JobFields = gcp.bigquery.Bigquery.Jobfield.values();              % array of all fields
%           2. JobFields = gcp.bigquery.Bigquery.Jobfield.values('ID','STATUS'); % array of selected fields
%
%           JobOption = gcp.bigquery.Bigquery.JobOption.fields(JobFields)
%
% Enum Constants for Field
% ------------------------
% CONFIGURATION 
% ETAG 
% ID 
% JOB_REFERENCE 
% SELF_LINK 
% STATISTICS 
% STATUS 
% USER_EMAIL 

%                 (c) 2020 MathWorks, Inc. 


properties
end

methods
	%% Constructor 
	function obj = JobField(varargin)
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Checking for class before Handle assignment
        if ~ isa(varargin{1},'com.google.cloud.bigquery.BigQuery$JobField[]')
            write(logObj,'error','JobField Object creation failed');
        else
            obj.Handle = varargin{1};
        end

	end
end

methods(Static)
    % Returns an array containing the constants of this enum type, in the order they are declared.
    function JobField = values()
        % Imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating JobFieldArray here. no input expected
        JobFieldJ = javaMethod('values','com.google.cloud.bigquery.BigQuery$JobField');
        
        % Wrapping into a MATLAB class object
        JobField = gcp.bigquery.BigQuery.JobField(JobFieldJ);
    end
    
    % Returns an array containing the constants of this enum type, in the order they are declared.
    function JobField = valueOf(varargin)
        % Imports
        import com.google.cloud.bigquery.BigQuery;
              
        JobFieldArrJ = javaArray('com.google.cloud.bigquery.BigQuery$JobField',nargin);
        for i = 1:nargin
            Field = varargin{i};
            % Creating JobFieldArray here. no input expected
            JobFieldJ = javaMethod('valueOf','com.google.cloud.bigquery.BigQuery$JobField',Field);
            % Assign field to the array
            JobFieldArrJ(i) =  JobFieldJ;
        end
        
        % Wrapping into a MATLAB class object
        JobField = gcp.bigquery.BigQuery.JobField(JobFieldArrJ);
    end
    
end %methods(Static)

end %class

% Java API Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/BigQuery.JobField.html
%
%  Supported Methods
%  ------------------
% static BigQuery.JobField	valueOf(String name)
% Returns the enum constant of this type with the specified name.
%
% static BigQuery.JobField[]	values()
% Returns an array containing the constants of this enum type, in the order they are declared.