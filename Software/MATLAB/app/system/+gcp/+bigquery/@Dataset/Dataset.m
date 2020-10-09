classdef Dataset  < gcp.bigquery.Object
% DATASET A Google BigQuery Dataset.
%
% Objects of this class are immutable.
% Dataset adds a layer of service-related functionality over DatasetInfo.
%  
% Usage
%       % create a client
%       
%          gbq = gcp.bigquery.BigQuery('credentials.json');
%
%       % create details such as Id,location etc to build a dataset
%
%          datasetId = gcp.bigquery.DatasetId.of("datasetname");
%          datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);
%
%       % create options/fields info which are to be returned when datasets
%       are queries or listed
%
%          datasetField = gcp.bigquery.BigQuery.DatasetField.valueOf
%          datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField)
%
%       % create a dataset
%
%         dataset = gbqclient.create(datasetInfo,datasetOption);

%                 (c) 2020 MathWorks, Inc. 


properties
end

methods
	%% Constructor 
	function obj = Dataset(varargin)
  
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Verifying class of the input argument to the Dataset constructor 
        if ~ isa(varargin{1},'com.google.cloud.bigquery.Dataset')
            write(logObj,'error','Dataset Object creation failed');
        else
            % Expected class positively verified. Assigning object as a
            % Hendle for MATLAB class object Dataset
            obj.Handle = varargin{1};
        
            % Uncomment for verbosity
            %    write(logObj,'debug','Dataset Handle created');
        end
	end
end

end %class