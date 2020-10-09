classdef DatasetDeleteOption  < gcp.bigquery.Object
% DATASETDELETEOPTION Class for specifying dataset delete options.
%   Returns object of class 'com.google.cloud.bigquery.BigQuery$DatasetDeleteOption'
%
% Usage
%
%   % Deletes dataset even if it has contents
%       DatasetDeleteOption = gcp.bigquery.BigQuery.DatasetDeleteOption.deleteContents()
%

%                 (c) 2020 MathWorks, Inc. 


properties

end

methods
	%% Constructor 
	function obj = DatasetDeleteOption(varargin)
        
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Validating class of input argument before Handle assignment
        if ~ isa(varargin{1},'com.google.cloud.bigquery.BigQuery$DatasetDeleteOption')
            write(logObj,'error','DatasetDeleteOption Object creation failed');
        else
            % Received expected class of the object and assigning it to the
            % Handle for MATLAB class object BigQuery.DatasetDeleteOption
            obj.Handle = varargin{1};
        end
        
    end % constructor
end

methods(Static)
    
            
    % Returns an option to delete a dataset even if non-empty.
    function DatasetDeleteOption = deleteContents()
        % imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Create a DatasetDeleteOption No inputs required
        DatasetDeleteOptionJ = javaMethod('deleteContents','com.google.cloud.bigquery.BigQuery$DatasetDeleteOption');
        
        % Wrapping into a MATLAB class object
        DatasetDeleteOption = gcp.bigquery.BigQuery.DatasetDeleteOption(DatasetDeleteOptionJ);
    end
    
end %methods(Static)

end %class

% Java API reference: https://googleapis.dev/java/google-cloud-bigquery/latest/com/google/cloud/bigquery/BigQuery.DatasetDeleteOption.html
%
% Supported Method
% ----------------
%
% static BigQuery.DatasetDeleteOption	deleteContents()
% Returns an option to delete a dataset even if non-empty.