 classdef FormatOptions  < gcp.bigquery.Object
% FORMATOPTIONS Base class for Google BigQuery format options. 
%
% This class defines the format of external data consumed by BigQuery, for either federated tables or load jobs.
% Load jobs support the following formats: AVRO, CSV, JSON, ORC, PARQUET
%
% Usage
%
%   formatOptions = gcp.bigquery.FormatOptions.csv()
%
%   formatOptions = gcp.bigquery.FormatOptions.json()
%
%   formatOptions = gcp.bigquery.FormatOptions.avro()
%
%   formatOptions = gcp.bigquery.FormatOptions.parquet()
%
%   formatOptions = gcp.bigquery.FormatOptions.orc()
%

%                 (c) 2020 MathWorks, Inc. 

properties
end

methods
	%% Constructor 
	function obj = FormatOptions(varargin)
        
    % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
     % Verify the java object class before wrapping it in the MATLAB object
     % class
        if ~ isa(varargin{1},'com.google.cloud.bigquery.FormatOptions')
            write(logObj,'error','FormatOptions Object creation failed');
        else
            obj.Handle = varargin{1};
        end
	end
end

methods(Static)
    
    function formatOptions = csv()
        % Returns csv formatoptions for source csv file 
        formatOptionsJ = javaMethod('csv','com.google.cloud.bigquery.FormatOptions');
        formatOptions = gcp.bigquery.FormatOptions(formatOptionsJ);
    end
    
    function formatOptions = avro()
        % Returns avro formatoptions for source avro file
        formatOptionsJ = javaMethod('avro','com.google.cloud.bigquery.FormatOptions');
        formatOptions = gcp.bigquery.FormatOptions(formatOptionsJ);
    end
    
    function formatOptions = orc()
        % Returns orc formatoptions for source orc file
        formatOptionsJ = javaMethod('orc','com.google.cloud.bigquery.FormatOptions');
        formatOptions = gcp.bigquery.FormatOptions(formatOptionsJ);
    end
    
    function formatOptions = parquet()
        % Returns parquet formatoptions for source parquet file
        formatOptionsJ = javaMethod('parquet','com.google.cloud.bigquery.FormatOptions');
        formatOptions = gcp.bigquery.FormatOptions(formatOptionsJ);
    end
    
    function formatOptions = json()
        % Returns json formatoptions for source json file
        formatOptionsJ = javaMethod('json','com.google.cloud.bigquery.FormatOptions');
        formatOptions = gcp.bigquery.FormatOptions(formatOptionsJ);
    end
end

end %class

%
% Reference for API: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/FormatOptions.html
%
% Supported Methods:
% ---------------------
% static FormatOptions	avro()
% Default options for AVRO format.
%
% static FormatOptions	orc()
% Default options for the ORC format.
%
% static FormatOptions	parquet()
% Default options for PARQUET format.
%
% static CsvOptions	csv()
% Default options for CSV format.
%
% static FormatOptions	json()
% Default options for NEWLINE_DELIMITED_JSON format.
%
%
% Unsupported Methods
% -------------------
% static FormatOptions	bigtable()
% Default options for BIGTABLE format.
%
% static FormatOptions	datastoreBackup()
% Default options for DATASTORE_BACKUP format.
% 
% boolean	equals(Object obj) 
% 
% String	getType()
% Returns the external data format, as a string.
%
% static FormatOptions	googleSheets()
% Default options for GOOGLE_SHEETS format.
%
% int	hashCode() 
%
% static FormatOptions	of(String format)
% Default options for the provided format.
%
% String	toString() 