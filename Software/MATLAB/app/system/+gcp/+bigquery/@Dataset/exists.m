function tf = exists(datasetobj, varargin)
% EXISTS Method - checks if current dataset exists and returns boolean
% status
%
%  tf = dataset.exists()

%                 (c) 2020 MathWorks, Inc.

%% Implementation       

% Imports
import com.google.cloud.bigquery.*;

% Set Logger
logObj = Logger.getLogger();
logObj.MsgPrefix = 'GCP:GBQ';

% Access Dataset Handle
datasetJ = datasetobj.Handle;

% Check for dataset
tf = datasetJ.exists();

if tf
    fprintf("\nDataset exists \n");
else
    fprintf("\nDataset does not exist \n");
end
end %function

