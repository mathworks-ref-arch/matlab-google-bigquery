classdef JobOption  < gcp.bigquery.Object
% JOBOPTION Class for specifying table get and create options.
%
% Usage
%
%       fields = gcp.bigquery.BigQuery.JobField.values()
%       JobOption = gcp.bigquery.Bigquery.JobOption.fields(fields)
%

%                 (c) 2020 MathWorks, Inc. 

properties
end

methods
	%% Constructor 
	function obj = JobOption(varargin)
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Checking for the Handle class
        if ~ isa(varargin{1},'com.google.cloud.bigquery.BigQuery$JobOption')
            write(logObj,'error','JobOption Object creation failed');
        else
            obj.Handle = varargin{1};
        end
	end
end %methods

methods(Static)
    
    % Returns an option to specify the job's fields to be returned by the RPC call.
    function JobOption = fields(fields)
        
        % Imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating DatasetOption. Required JobField object as input
        JobOptionJ = javaMethod('fields','com.google.cloud.bigquery.BigQuery$JobOption', fields.Handle);
        
        % Wrapping into a MATLAB class object
        JobOption = gcp.bigquery.BigQuery.JobOption(JobOptionJ);

    end
    
end % methods(Static)

end %class

% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/BigQuery.JobOption.html
%
% Java API options
%--------------------
% static BigQuery.JobOption	fields(BigQuery.JobField... fields)
% Returns an option to specify the job's fields to be returned by the RPC call.