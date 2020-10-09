function dtable = listDatasets(gbq, varargin)
% LISTDATASETS Method to list the project's datasets
%
% Usage:
%
%   % create gbq client
%   gbq = gcp.bigquery.BigQuery('credentials.json');
%
%   % create options/configs for how to list datasets
%   datasetListOption1 = ...
%   gcp.bigquery.BigQuery.DatasetListOption.all/labelFilter/pageSize/pageToken(input);
%
%   datasetList = gbq.listDatasets(datsetListOption1,....,datasetListOptionN);
%

%                 (c) 2020 MathWorks, Inc.

%% Accessing GBQ client Handle
gbqJ = gbq.Handle;

% Create DatasetListOptions

% Expecting 1 or more DatasetListOption as input arguments
n = numel(varargin);

% Checking for number of input arguments
if n < 1
    warning('You need to provide atleast one datasetListOption');
else
    % Creating array of DatasetListOptions with n as size
    datasetlistOptionArray = javaArray('com.google.cloud.bigquery.BigQuery$DatasetListOption',n);
    
    % cnt is a flag
    cnt = 0;
    
    % Iterate over input arguments
    for i = 1:numel(varargin)
        
        % Check for class of every input argument
        if isa(varargin{i},'gcp.bigquery.BigQuery.DatasetListOption')
            
            % Assign to array if class of input argument is as expected
            datasetlistOptionArray(i) = varargin{i}.Handle;
            
            % increment counter - sets flag to true
            cnt = cnt+1;
        else
            % incorrect class of input argument
            warning('Input needs to be of type gcp.bigquery.BigQuery.DatasetListOption');
        end
        % Array assignment completion
    end
    % Check flag for atleast one assignment to the array
    
    if cnt < 1
        warning('DatasetListOptions could not be created due to incorrect input types');
    else
        % List datasets for this project
        datasetlist = gbqJ.listDatasets(datasetlistOptionArray);
        
        % Iterate over datasets in this project
        datasetall = datasetlist.iterateAll;
        
        % Creating iterator
        datasetiterator = datasetall.iterator;
        
        % Dataset Table;
        dtable = table;
        % List datasets
        while datasetiterator.hasNext
            cdataset = datasetiterator.next;
            datasetid = cdataset.getDatasetId;
            generationid = cdataset.getGeneratedId;
            dtable = vertcat(dtable,table(string(datasetid.getDataset),string(generationid))); %#ok<*AGROW>
        end
        % Check if datasets exist for listing
        if isequal(size(dtable,1),0)
            fprintf('No datasets to list in the project %s',string(datasetId));
        else
            % Setting Column names for dataset listing table information of this project
            dtable.Properties.VariableNames= {'DatasetId','GenerationId'};
        end
        
    end %if
    
end % if

end %function
