classdef QueryOption  < gcp.bigquery.Object
% QUERYOPTION Summary of this class goes here
%   
% Usage
%
%       QueryResultsOption = gcp.bigquery.BigQuery.maxWaitTime(maxWaitTime)
%       QueryResultsOption = gcp.bigquery.BigQuery.pageSize(pageSize)
%       QueryOption = gcp.bigquery.BigQuery.of(QueryResultsOption)
 
%                 (c) 2020 MathWorks, Inc. 


properties
end

methods
	%% Constructor 
	function obj = QueryOption(varargin)
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Validating class of the input object before assigning Handle
        if ~ isa(varargin{1},'com.google.cloud.bigquery.BigQuery$QueryOption')
            write(logObj,'error','QueryOption Object creation failed');
        else
            obj.Handle = varargin{1};
        end
	end
end

methods(Static)

    % Returns an option that sets how long to wait for the query to complete, in milliseconds, before returning.    
    function QueryOption = of(resultsOption)
        % imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating QueryOption. resultsOption is expected to be of
        % the type gcp.bigquery.BigQuery.QueryResultsOption
        QueryOptionJ = javaMethod('of','com.google.cloud.bigquery.BigQuery$QueryOption',resultsOption.Handle);
        
        % wrapping into a MATLAB class object
        QueryOption = gcp.bigquery.BigQuery.QueryOption(QueryOptionJ);
    end
end %methods(Static)

end %class

% Reference:https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/BigQuery.QueryOption.html
%
% Java API options
% -----------------
%
% Method supported:
% ----------------
% static BigQuery.QueryOption	of(BigQuery.QueryResultsOption resultsOption) 
%
% Method unsupported
% ------------------
% static BigQuery.QueryOption	of(com.google.cloud.RetryOption waitOption) 