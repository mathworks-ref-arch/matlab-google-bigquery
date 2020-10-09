classdef WriteDisposition	< gcp.bigquery.Object
% WRITEDISPOSITION Specifies whether the job is allowed to create new tables.
%  
% Usage:
%
%    % Set writeDisposition for a table in order to allow appending with new data
%
%           writeDispositionEnum = 'WRITE_APPEND';
%           writeDispositionConfig = gcp.bigquery.JobInfo.WriteDisposition.valueOf(writeDispositionEnum);
%           loadJobConfigurationBuilder = loadJobConfigurationBuilder.setWriteDisposition(writeDispositionConfig);
%
% Enum Constant and Description
% -----------------------------
% * WRITE_APPEND : Configures the job to append data to the table if it already exists.
%     
% * WRITE_EMPTY : Configures the job to fail with a duplicate error if the table already exists.
% 
% * WRITE_TRUNCATE : Configures the job to overwrite the table data if table already exists.

%                 (c) 2020 MathWorks, Inc. 

    properties
       
    end
    
    methods
        function obj = WriteDisposition(varargin)
            % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            
            % Checking for class of returned object before Handle
            % assignement
            if ~ isa(varargin{1},'com.google.cloud.bigquery.JobInfo$WriteDisposition')
                write(logObj,'error','JobInfo.WriteDisposition Object creation failed');
            else
                obj.Handle = varargin{1};
            end
        end
        
    end
    
    methods (Static)
        
        % Returns the enum constant of this type with the specified name.
        function writeDisposition	= valueOf(name)
            writeDispositionJ = javaMethod('valueOf','com.google.cloud.bigquery.JobInfo$WriteDisposition',name);
            writeDisposition = gcp.bigquery.JobInfo.WriteDisposition(writeDispositionJ);
        end
        
    end
end

%% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/JobInfo.WriteDisposition.html
% 
% Java API supported
% -------------------
% static JobInfo.WriteDisposition	valueOf(String name)
% Returns the enum constant of this type with the specified name.
%
% Unsupported API
% ---------------
% static JobInfo.WriteDisposition[]	values()
% Returns an array containing the constants of this enum type, in the order they are declared.
