classdef QueryResultsOption  < gcp.bigquery.Object
% QUERYRESULTSOPTION Class for specifying query results options.  
% Returns an option for the query results to be returned such as wait time, pagesize, row index to begin from etc 
%
% Usage
%
%       QueryResultsOption = gcp.bigquery.BigQuery.maxWaitTime(maxWaitTime)
%       QueryResultsOption = gcp.bigquery.BigQuery.pageSize(pageSize)
%       QueryResultsOption = gcp.bigquery.BigQuery.startIndex(startIndex)
%       QueryResultsOption = gcp.bigquery.BigQuery.pageToken(pageToken)
%
%       QueryOption = gcp.bigquery.BigQuery.of(QueryResultsOption)

%                 (c) 2020 MathWorks, Inc. 

properties
end

methods
	%% Constructor 
	function obj = QueryResultsOption(varargin)

        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Checking for class before assigning Handle
        if ~ isa(varargin{1},'com.google.cloud.bigquery.BigQuery$QueryResultsOption')
            write(logObj,'error','QueryResultsOption Object creation failed');
        else
            obj.Handle = varargin{1};
        end
        
	end
end

methods(Static)

    % Returns an option that sets how long to wait for the query to complete, in milliseconds, before returning.    
    function QueryResultsOption = maxWaitTime(maxWaitTime)
        % imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating QueryResultsOption. pageToken is expected to be of the type string
        QueryResultsOptionJ = javaMethod('maxWaitTime','com.google.cloud.bigquery.BigQuery$QueryResultsOption',maxWaitTime);
        
        % wrapping into a MATLAB class object
        QueryResultsOption = gcp.bigquery.BigQuery.QueryResultsOption(QueryResultsOptionJ);
    end
    
    % Returns an option to specify the maximum number of rows returned per page.
    function QueryResultsOption = pageSize(pageSize)
        % imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating QueryResultsOption. pageSize is expected to be of the type string
        QueryResultsOptionJ = javaMethod('pageSize','com.google.cloud.bigquery.BigQuery$QueryResultsOption',pageSize);
        
        % wrapping into a MATLAB class object
        QueryResultsOption = gcp.bigquery.BigQuery.QueryResultsOption(QueryResultsOptionJ);
    end
    
    % Returns an option to specify the page token from which to start getting query results.
    function QueryResultsOption = pageToken(pageToken)
        % imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating QueryResultsOption. pageToken is expected to be of the type string
        QueryResultsOptionJ = javaMethod('pageToken','com.google.cloud.bigquery.BigQuery$QueryResultsOption',pageToken);
        
        % wrapping into a MATLAB class object
        QueryResultsOption = gcp.bigquery.BigQuery.QueryResultsOption(QueryResultsOptionJ);
    end
    
    % Returns an option that sets the zero-based index of the row from which to start getting query results.
    function QueryResultsOption = startIndex(startIndex)
        % imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating QueryResultsOption.startIndex is expected to be of the
        % type long
        QueryResultsOptionJ = javaMethod('startIndex','com.google.cloud.bigquery.BigQuery$QueryResultsOption',startIndex);
        
        % wrapping into a MATLAB class object
        QueryResultsOption = gcp.bigquery.BigQuery.QueryResultsOption(QueryResultsOptionJ);
    end

end


end %class

% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/BigQuery.QueryResultsOption.html
%
% Java API options
%--------------------
% static BigQuery.QueryResultsOption	maxWaitTime(long maxWaitTime)
% Returns an option that sets how long to wait for the query to complete, in milliseconds, before returning.
% 
% static BigQuery.QueryResultsOption	pageSize(long pageSize)
% Returns an option to specify the maximum number of rows returned per page.
% 
% static BigQuery.QueryResultsOption	pageToken(String pageToken)
% Returns an option to specify the page token from which to start getting query results.
% 
% static BigQuery.QueryResultsOption	startIndex(long startIndex)
% Returns an option that sets the zero-based index of the row from which to start getting query results.