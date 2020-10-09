classdef DatasetListOption  < gcp.bigquery.Object
% DATASETLISTOPTION Class for specifying dataset list options.
%
% Usage
%
%       DatasetListOption = gcp.bigquery.BigQuery.DatasetListOption.all()
% 
%       DatasetListOption = gcp.bigquery.BigQuery.DatasetListOption.labelFilter(labelFilter)
% 
%       DatasetListOption = gcp.bigquery.BigQuery.DatasetListOption.pageToken(pageToken)
% 
%       DatasetListOption = gcp.bigquery.BigQuery.DatasetListOption.pageSize(pageSize)
%
%       datasetList = gbq.listDatasets(datsetListOption1,....,datasetListOptionN);

%                 (c) 2020 MathWorks, Inc. 


properties

end

methods
	%% Constructor 
	function obj = DatasetListOption(varargin)

        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Validating class of the input argument before handle assignment
        if ~ isa(varargin{1},'com.google.cloud.bigquery.BigQuery$DatasetListOption')
            write(logObj,'error','DatasetListOption Object creation failed');
        else
            obj.Handle = varargin{1};
        end
	end
end

methods(Static)
    
    % Returns an options to list all datasets, even hidden ones.
    function DatasetListOption = all()
        % imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating DatasetListOption. No inputs required
        DatasetListOptionJ = javaMethod('all','com.google.cloud.bigquery.BigQuery$DatasetListOption');
        
        % wrapping into a MATLAB class object
        DatasetListOption = gcp.bigquery.BigQuery.DatasetListOption(DatasetListOptionJ);
    end
    
    % Returns an option to specify a label filter.
    function DatasetListOption = labelFilter(labelFilter)
        % imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating DatasetListOption. labelFilter is expected to be of the type string
        DatasetListOptionJ = javaMethod('labelFilter','com.google.cloud.bigquery.BigQuery$DatasetListOption',labelFilter);
        
        % wrapping into a MATLAB class object
        DatasetListOption = gcp.bigquery.BigQuery.DatasetListOption(DatasetListOptionJ);
    end
    
    % Returns an option to specify the page token from which to start listing datasets.
    function DatasetListOption = pageToken(pageToken)
        % imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating DatasetListOption. pageToken is expected to be of the type string
        DatasetListOptionJ = javaMethod('pageToken','com.google.cloud.bigquery.BigQuery$DatasetListOption',pageToken);
        
        % wrapping into a MATLAB class object
        DatasetListOption = gcp.bigquery.BigQuery.DatasetListOption(DatasetListOptionJ);
    end
    
    % Returns an option to specify the maximum number of datasets returned per page.
    function DatasetListOption = pageSize(pageSize)
        % imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating DatasetListOption. pageSize is expected to be of the type long
        DatasetListOptionJ = javaMethod('pageSize','com.google.cloud.bigquery.BigQuery$DatasetListOption',pageSize);
        
        % wrapping into a MATLAB class object
        DatasetListOption = gcp.bigquery.BigQuery.DatasetListOption(DatasetListOptionJ);
    end
end

end %class

% Java API Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/BigQuery.DatasetListOption.html
%
%  Supported Methods
% -------------------
% static BigQuery.DatasetListOption	all()
% Returns an options to list all datasets, even hidden ones.
%
% static BigQuery.DatasetListOption	labelFilter(String labelFilter)
% Returns an option to specify a label filter.
%
% static BigQuery.DatasetListOption	pageSize(long pageSize)
% Returns an option to specify the maximum number of datasets returned per page.
%
% static BigQuery.DatasetListOption	pageToken(String pageToken)
% Returns an option to specify the page token from which to start listing datasets.
