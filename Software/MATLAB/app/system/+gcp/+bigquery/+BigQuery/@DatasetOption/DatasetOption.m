classdef DatasetOption  < gcp.bigquery.Object
% DATASETOPTION Class for specifying dataset get, create and update options.
%
% USAGE
%
%       datasetField = gcp.bigquery.BigQuery.DatasetField.valuesOf()
%       datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField)

%                 (c) 2020 MathWorks, Inc. 


properties

end

methods
	%% Constructor 
	function obj = DatasetOption(varargin)
        
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Validating class of input arguments before handle assignment
        if ~ isa(varargin{1},'com.google.cloud.bigquery.BigQuery$DatasetOption')
            write(logObj,'error','DatasetOption Object creation failed');    
        else
            obj.Handle = varargin{1};
        end
	end
end

methods(Static)
    
    % Returns an option to specify the dataset's fields to be returned by the RPC call.
    function DatasetOption = fields(fields)
        % Imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating DatasetOption. Required DatasetField object as input
        DatasetOptionJ = javaMethod('fields','com.google.cloud.bigquery.BigQuery$DatasetOption', fields.Handle);
        
        % Wrapping into a MATLAB class object
        DatasetOption = gcp.bigquery.BigQuery.DatasetOption(DatasetOptionJ);

    end
    
end % methods(Static)

end %class

% Java API Reference : https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/BigQuery.DatasetOption.html
% 
% Supported method
% -----------------
%
% static BigQuery.DatasetOption	fields(BigQuery.DatasetField... fields)
% Returns an option to specify the dataset's fields to be returned by the RPC call.
