classdef TableResult  < gcp.bigquery.Object
% TABLERESULT Returns query results from BigQuery as a TableResult object
% See function `gbq2table` for converting TableResult to a MATLAB table
%
% This class is used as a holder for bigquery.query() and job.getQueryResults() methods return object
% 
% Usage
%
%       tableResult = gbq.query(queryJobConfiguration)
%
%       tableResult = job.getQueryResults(queryResultsOption)

%                 (c) 2020 MathWorks, Inc. 



properties
end

methods
	%% Constructor 
	function obj = TableResult(varargin)
            % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        if ~ isa(varargin{1},'com.google.cloud.bigquery.TableResult')
            write(logObj,'error','TableResult Object creation failed');
        else
            obj.Handle = varargin{1};
        end
	end
end

end %class

% Class Methods
%
% boolean                       equals(Object obj) 
% TableResult                   getNextPage() 
% String                        getNextPageToken() 
% Schema                        getSchema()
% long                          getTotalRows()
% Iterable<FieldValueList>  	getValues() 
% int                           hashCode() 
% boolean                       hasNextPage() 
% Iterable<FieldValueList>      iterateAll() 
% String                        toString() 