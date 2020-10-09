function tf = deleteDataset(gbq, varargin)
% DELETEDATASET Method to delete a dataset
%   
% Usage
%
%       gbq = gcp.bigquery.BigQuery()
%       tf = gbq.deleteDataset('datasetid')

%                 (c) 2020 MathWorks, Inc.

%% Implementation

% Access gbq java client handle
clientObj = gbq.Handle;

% Access datasetId as string
if ~isempty(varargin{1})
    datasetId = varargin{1};
    if isa(datasetId,'string') || isa(datasetId,'char')
        datasetId = string(datasetId);
       
        % Create datasetDeleteOption
        datasetDeleteOption = gcp.bigquery.BigQuery.DatasetDeleteOption.deleteContents();
        datasetDeleteOptionsJ = javaArray('com.google.cloud.bigquery.BigQuery$DatasetDeleteOption',1);
        datasetDeleteOptionsJ(1) = datasetDeleteOption.Handle;
        % Delete dataset
        tf = clientObj.delete(datasetId,datasetDeleteOptionsJ);
        if tf
            fprintf("\nDataset deleted successfully\n");
        else
            fprintf("\nDataset not deleted successfully\n");
        end
    else
        warning("expecting input argument to be a string");
    end
else
    warning("Expecting datasetid to be passed as an input argument of type String");
end



%
%%

end %function
% boolean	delete(String datasetId, BigQuery.DatasetDeleteOption... options)
% Deletes the requested dataset.