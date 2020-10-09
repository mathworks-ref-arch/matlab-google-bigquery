function tf = delete(datasetobj)
% DELETE deletes current dataset and returns TRUE or FALSE depending
% on success of the deletion
%
%  Usage
%
%     tf = dataset.delete()


%                 (c) 2020 MathWorks, Inc.

%% Implementation       

% Imports
import com.google.cloud.bigquery.*;

% Set Logger
logObj = Logger.getLogger();
logObj.MsgPrefix = 'GCP:GBQ';

% Access Dataset Handle
datasetJ = datasetobj.Handle;

% Create datasetDeleteOption
datasetDeleteOption = gcp.bigquery.BigQuery.DatasetDeleteOption.deleteContents();

% There could be multiple datasetDeleteOptions one might want to create. In
% that case One can use an array of deletedatasetoption such as one created
% below. Size of an array can be provided based on number of options.
datasetDeleteOptionsJ = javaArray('com.google.cloud.bigquery.BigQuery$DatasetDeleteOption',1);

% Assigning the datasetDeleteOption to the array
datasetDeleteOptionsJ(1) = datasetDeleteOption.Handle;

% Delete table
tf = datasetJ.delete(datasetDeleteOptionsJ);

if tf
    fprintf("\nDataset deleted successfully\n");
   % clear datasetobj;
else
    fprintf("\nDataset not deleted successfully\n");
end
end %function

