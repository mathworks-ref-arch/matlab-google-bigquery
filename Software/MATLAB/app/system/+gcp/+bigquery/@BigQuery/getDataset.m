function Dataset = getDataset(gbq, varargin) 
% GETDATASET Method to request an existing dataset
%
% This method will call the Google Big Query project configured to request
% a list of projects.
%
% Usage
%
%       gbq = gcp.bigquery.BigQuery('credentials.json')
%       dataSet = gbq.getDataset(datasetId); ,where datsetId is of type "gcp.bigquery.DatasetId"
%          or
%       dataSet = gbq.getDataset("datasetId"); , where datasetId is of type string or char

%                 (c) 2020 MathWorks, Inc.

%% Implementation

% Imports
import com.google.cloud.bigquery.*;

% Set Logger
logObj = Logger.getLogger();
logObj.MsgPrefix = 'GCP:GBQ';

% Check for the correct number of input arguments
if ~isequal(numel(varargin),1)
    write(logObj,'error','Unexpected number of Inputs');
else
    % Check for GBQ client
    if ~ isa(gbq,'gcp.bigquery.BigQuery')
        write(logObj,'error','Expecting an object of class gcp.bigquery.BigQuery');
    else
        % access java client object
        gbqJ = gbq.Handle;
        if ~ isa(gbqJ,'com.google.cloud.bigquery.BigQueryImpl')
            write(logObj,'error','Expecting an object of class com.google.cloud.bigquery.BigQueryImpl');
        else
            % create metadata fields which need to be extracted for a given dataset 
            datasetField = gcp.bigquery.BigQuery.DatasetField.valuesOf;
            % option for extracting dataset handle with fields as inputs
            datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField);
            datasetOptions = javaArray('com.google.cloud.bigquery.BigQuery$DatasetOption',1);
            datasetOptions(1) = datasetOption.Handle;
            
            % Extracting dataset based on datasetId
            % Based on provided input arguments type 'string', 'char',
            % 'DatasetId' support for methods 
            switch(class(varargin{1}))
                case 'string'
                    datasetId = varargin{1};
                    Dataset = gcp.bigquery.Dataset(gbqJ.getDataset(datasetId,datasetOptions));
                case 'char'
                    datasetId = varargin{1};
                    Dataset = gcp.bigquery.Dataset(gbqJ.getDataset(datasetId,datasetOptions));
                case 'gcp.bigquey.DatasetId'
                    datasetIdJ = varargin{1}.Handle;
                    Dataset = gcp.bigquery.Dataset(gbqJ.getDataset(datasetIdJ,datasetOptions));
                otherwise
                    write(logObj,'error','Expected inputs are DatasetId of class string or gcp.bigquery.DatasetId');
            
            end % switch - check class of DatasetId
            
        end % if - check class of gbq Handle
        
    end % if - check class of obj
    
end % if - check number of inputs

end %function