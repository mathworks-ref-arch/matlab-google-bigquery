function dtable = listTables(gbq, datasetId)
% LISTTABLES Method to list the tables in the dataset
%
%   gbq = gcp.bigquery.BigQuery('credentials.json');
%   tableList = gbq.listTables('datasetId');
%

%                 (c) 2020 MathWorks, Inc.

    % Access Java Handle
    gbqJ = gbq.Handle;

    % Creating array of TableListOptions with size 1
    tableListOption =  gcp.bigquery.BigQuery.TableListOption.pageSize(100);
    tableListOptionArray = javaArray('com.google.cloud.bigquery.BigQuery$TableListOption',1);
    tableListOptionArray(1) = tableListOption.Handle;

    % Call listTables method of the gbq client with a datasetId and options for
    % listing table information
    tableList = gbqJ.listTables(datasetId,tableListOptionArray);

    % Iterate over datasets in this project
    tableall = tableList.iterateAll;

    % Creating iterator
    tableiterator = tableall.iterator;

    % Dataset Table Info container;
    dtable = table;
    
    % List datasets
    while tableiterator.hasNext
        % Accessing next table
        ctable = tableiterator.next;

        % Accessing information such as tableid and generation id of the
        % current table
        tableid = ctable.getTableId;
        generationid = ctable.getGeneratedId;
        % Adding row to the table listing ingormation about tables of this
        % project
        % Information consists of DatasetId, TableId and GenerationId
        dtable = vertcat(dtable,table(string(tableid.getDataset),string(tableid.getTable),string(generationid))); %#ok<*AGROW>
        
    end
    
    % Check if tables exist for listing
    if isequal(size(dtable,1),0)
        fprintf('No tables to list in the dataset %s',string(datasetId));
    else
        % Setting Column names for table listing table information of this project
        dtable.Properties.VariableNames= {'Dataset','Table','GenerationId'};      
    end

end %function


%% Supported methods
% com.google.api.gax.paging.Page<Table> listTables(DatasetId datasetId,
%                                                  BigQuery.TableListOption... options)
% com.google.api.gax.paging.Page<Table> listTables(String datasetId,
%                                                  BigQuery.TableListOption... options)
