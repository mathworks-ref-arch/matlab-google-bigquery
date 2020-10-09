classdef CreateDisposition	< gcp.bigquery.Object
% CREATEDISPOSITION Specifies whether the job is allowed to create new tables.
%  
% Usage:
%
%    % Set createDisposition for a table in order to allow creation of new
%    % table if needed
%
%           createDispositionEnum = 'CREATE_IF_NEEDED';
%           createDispositionConfig = gcp.bigquery.JobInfo.CreateDisposition.valueOf(createDispositionEnum);
%           loadJobConfigurationBuilder = loadJobConfigurationBuilder.setCreateDisposition(createDispositionConfig);
%           queryJobConfigurationBuilder = queryJobConfigurationBuilder.setCreateDisposition(createDispositionConfig);
%           
% Enum Constant and Description
% -----------------------------
% * CREATE_IF_NEEDED : Configures the job to create the table if it does not exist.
%
% * CREATE_NEVER : Configures the job to fail with a not-found error if the table does not exist.
%

%                 (c) 2020 MathWorks, Inc. 
    properties
       
    end
    
    methods
        function obj = CreateDisposition(varargin)
          % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            
            % Checking for class of returned object before Handle
            % assignement
            if ~ isa(varargin{1},'com.google.cloud.bigquery.JobInfo$CreateDisposition')
                write(logObj,'error','JobInfo.CreateDisposition Object creation failed');
            else
                obj.Handle = varargin{1};
            end
        end
        
    end
    
    methods (Static)
        
        % Returns the enum constant of this type with the specified name.
        function createDisposition	= valueOf(name)
            CreateDispositionJ = javaMethod('valueOf','com.google.cloud.bigquery.JobInfo$CreateDisposition',name);
            createDisposition = gcp.bigquery.JobInfo.CreateDisposition(CreateDispositionJ);
        end
        
    end
end

% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/JobInfo.CreateDisposition.html
% 
% Java API supported
% -------------------
% static JobInfo.CreateDisposition	valueOf(String name)
% Returns the enum constant of this type with the specified name.
% 

% Unsupported API
% ----------------
% static JobInfo.CreateDisposition[]	values()
% Returns an array containing the constants of this enum type, in the order they are declared.

