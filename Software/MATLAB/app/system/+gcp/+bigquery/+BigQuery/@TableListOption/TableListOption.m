classdef TableListOption  < gcp.bigquery.Object
% TABLELISTOPTION Class for specifying table list options.
%  
% Usage (Implicitly used by method listTables in gcp.bigquery.Bigquery
%
%    gbq = gcp.bigquery.BigQuery("credentials.json");
%    tableListOption = gcp.bigquery.Bigquery.TableListOption.pageSize(pageSize)
%    tableList = gbq.listTables('datsetId');


%                 (c) 2020 MathWorks, Inc. 


properties
end

methods
	%% Constructor 
	function obj = TableListOption(varargin)
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Checking class before handle assignement
        if ~ isa(varargin{1},'com.google.cloud.bigquery.BigQuery$TableListOption')
            write(logObj,'error','TableListOption Object creation failed');
        else
            obj.Handle = varargin{1};
        end
	end
	
end

methods(Static)
    
    % pagesize method is used for configuring number of tables you would like list in a page
    % when receiving response
    function tableListOption = pageSize(pageSize)
        % Imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Input pageSize is of type long - MATLAB double
        tableListOptionJ = javaMethod('pageSize','com.google.cloud.bigquery.BigQuery$TableListOption',pageSize);
        
        % Wrapping into a MATLAB class object
        tableListOption = gcp.bigquery.BigQuery.TableListOption(tableListOptionJ);
    end
end

end %class
% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/BigQuery.TableListOption.html
%
% Java API options
%--------------------
% static BigQuery.TableListOption	pageSize(long pageSize)
% Returns an option to specify the maximum number of tables returned per page.