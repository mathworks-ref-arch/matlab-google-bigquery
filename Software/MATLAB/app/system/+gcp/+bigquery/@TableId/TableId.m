classdef TableId  < gcp.bigquery.Object
% TABLEID Returns TableId for a BigQuery Table 
%   
% Usage
%
%    tableId = gcp.bigquery.TableId.of("DatasetId","TableId")
%       

%                 (c) 2020 MathWorks, Inc. 


properties
end

methods
	%% Constructor 
	function obj = TableId(varargin)
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        switch (class(varargin{1}))
            case 'com.google.cloud.bigquery.TableId'
                obj.Handle = varargin{1};
            otherwise
                write(logObj,'error','TableId Object creation failed');
        end
    end
    
end

methods (Static)
    % Creates a table identity given dataset's and table's user-defined ids
    function tableId = of(destinationDataset,destinationTable)
        % Create TableId
        tableIdJ = javaMethod('of','com.google.cloud.bigquery.TableId',destinationDataset, destinationTable);
        
        % Wrapping java tableIdJ into a MATLAB object gcp.bigquery.TableId
        tableId = gcp.bigquery.TableId(tableIdJ);
    end
end

end %class

% Java API Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/TableId.html
%
% Supported Methods: 
% 
% static TableId	of(String dataset, String table)
% Creates a table identity given dataset's and table's user-defined ids.