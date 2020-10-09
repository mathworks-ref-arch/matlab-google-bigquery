function tf = deleteTable(gbq, TableId)
% DELETETABLE Method to delete a table
%
% Usage
%
%       gbq = gcp.bigquery.BigQuery()
%       tf = gbq.deleteTable(TableId)

%                 (c) 2020 MathWorks, Inc.

%% Implementation

% Access gbq java client handle
clientObj = gbq.Handle;

tableIdJ = TableId.Handle;

% Returns true/false based on success of the deleteion
tf = clientObj.delete(tableIdJ);

if tf
    fprintf("\nDataset deleted successfully\n");
else
    fprintf("\nDataset not deleted successfully\n");
end


end %function

% boolean	delete(String datasetId, BigQuery.DatasetDeleteOption... options)
% Deletes the requested dataset.