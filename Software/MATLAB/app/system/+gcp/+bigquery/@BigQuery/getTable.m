function Table = getTable(gbq, varargin) 
% GETTABLE Method to request an existing bigquery TABLE
%
% Usage
%
%   gbq = gcp.bigquery.BigQuery('credentials.json')
%   gbqtable = gbq.getTable('datasetId','tableId');

%                 (c) 2020 MathWorks, Inc.

% Imports
import com.google.cloud.bigquery.*;

% Set Logger
logObj = Logger.getLogger();
logObj.MsgPrefix = 'GCP:GBQ';

% Checking if the number of input arguments are either 1-2
if numel(varargin)< 1 || numel(varargin)> 2
    write(logObj,'error','Unexpected number of Inputs');
else
    % Check for GBQ client
    if ~ isa(gbq,'gcp.bigquery.BigQuery')
        write(logObj,'error','Expecting an object of class gcp.bigquery.BigQuery');
    else
        % Get java class object from client object gbq
        gbqJ = gbq.Handle;
        if ~ isa(gbqJ,'com.google.cloud.bigquery.BigQueryImpl')
            write(logObj,'error','Expecting an object of class com.google.cloud.bigquery.BigQueryImpl');
        else
            % provide table fields for creating TableOptions for extracting
            % Table handle of an existing Table within a bigquery dataset
            tableField = gcp.bigquery.BigQuery.TableField.values;
            tableOption = gcp.bigquery.BigQuery.TableOption.fields(tableField);
            tableOptions = javaArray('com.google.cloud.bigquery.BigQuery$TableOption',1);
            tableOptions(1) = tableOption.Handle;
            
            % Extract handle to an existing table with combination of input
            % arguments such as datasetId and tableId or just unique
            % tableId
            switch(class(varargin{1}))
                case 'string'
                    datasetId = string(varargin{1}); %string
                    tableId = string(varargin{2});   %string
                    Table = gcp.bigquery.Table(gbqJ.getTable(datasetId,tableId,tableOptions));
                case 'char'
                    datasetId = string(varargin{1}); %string
                    tableId = string(varargin{2});   %string
                    Table = gcp.bigquery.Table(gbqJ.getTable(datasetId,tableId,tableOptions));                   
                case 'gcp.bigquey.TableId'
                    tableIdJ = varargin{1}.Handle; 
                    Table = gcp.bigquery.Table(gbqJ.getTable(tableIdJ,tableOption));
                otherwise
                    write(logObj,'error','Expected inputs are either DatasetId & TableId of class string or just Table Id of class gcp.bigquery.TableId');
            
            end % switch - check class of DatasetId
            
        end % if - check class of gbq Handle
        
    end % if - check class of obj
    
end % if - check number of inputs

end %function