classdef BigQuery < gcp.bigquery.Object
    % BIGQUERY Google Big Query Client Library for MATLAB
    
    %                 (c) 2020 MathWorks, Inc.
    properties
        ProjectId
        Location
    end
    
    
    
    methods
        %% Constructor
        function obj = BigQuery(varargin)
            
            % Implementing GBQ client
            import com.google.cloud.bigquery.BigQuery;
            import com.google.cloud.bigquery.BigQueryOptions;
            
            % Setting Logger for GBQ
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GCS';
            
            % Looking for JVM locally and verifying whether current MATLAB
            % version is supported (Version support starting R2018a)
            if ~usejava('jvm')
                write(logObj,'error','MATLAB must be used with the JVM enabled');
            end
            if verLessThan('matlab','9.4') % R2018a
                write(logObj,'error','MATLAB Release 2018a or newer is required');
            end
            
            % Check if input is for wrapping a GBQ client object or
            % credentials to build a fresh client
            if nargin==1 && isa(varargin{1},'com.google.cloud.bigquery.BigQueryImpl')
                gbqJ = varargin{1}; % get client object
                obj.Handle = gbqJ;  % assigning MATLAB class handle for the client
                gbqOptionsJ = gbqJ.getOptions; % get existing bigqueryoptions
                obj.ProjectId = char(gbqOptionsJ.getProjectId); % set projectId
                obj.Location = char(gbqOptionsJ.getLocation); % set location
            else
                % Fetching credentials from environment variable for creating an
                % Authenticated Google BigQuery Client in MATLAB
                %
                % Note: Make sure steps in Documentation/Authentication.md has been followed
                % check for explicit credential input
                if nargin>0 && (isa(varargin{1},'string') || isa(varargin{1},'char'))
                    credentialsFilePath = which(varargin{1});
                    % if file input argument not found on path
                    if isempty(credentialsFilePath)
                        write(logObj,'error',strcat('Could not find ', varargin{1},' on path'));
                    end
                else
                    try
                        % Load credentials for client using default
                        % credentials configured by user
                        credentialsFilePath = getenv('GOOGLE_APPLICATION_CREDENTIALS');
                    catch
                        warning('Expected input credentials file on path or an existing json file(credentials.json) containing credentials within %s\config',gbqroot);
                        credentialsFilePath = '';
                    end
                end
                
                % Check for a valid credentials Path
                if ~isempty(credentialsFilePath)
                    import com.google.auth.oauth2.GoogleCredentials;
                    % Read credentials from file
                    fileStreamJ = javaObject('java.io.FileInputStream',credentialsFilePath);
                    % Create service credentials
                    credentialsJ = javaMethod('fromStream','com.google.auth.oauth2.GoogleCredentials',fileStreamJ);
                    
                    % Use the BigQueryOptions.getDefaultInstance() function to use the default authentication options.
                    gbqOptions = gcp.bigquery.BigQueryOptions.getDefaultInstance;
                    
                    % Create the BigQueryOptions.Builder object to set credentials
                    gbqOptionsBuilder = gbqOptions.newBuilder();
                    gbqOptionsBuilder = gbqOptionsBuilder.setCredentials(credentialsJ);
                    
                    % Build the BigQueryOptions.Builder object with credentials to get
                    % BigQueryOptions with given authentication details
                    gbqOptions = gbqOptionsBuilder.build();
                    gbqOptionsJ = gbqOptions.Handle;
                    
                    % Use the BigQueryOptions.getService() function to create the authenticated BigQuery client.
                    gbqJ = gbqOptionsJ.getService;
                    obj.Handle = gbqJ;
                    
                    % Get ProjectId for assigning the Handle Property
                    gbqProjectId = char(gbqOptionsJ.getProjectId);
                    obj.ProjectId = gbqProjectId;
                    obj.Location = char(gbqOptionsJ.getLocation);
                else
                    write(logObj,'error','Could not find a valid credentials to authenticate a client');
                end % if for credentials file exists
                
            end %else part of check where inputs are expected to be credentials and not a bigquery object
        
        end % constructor
        
        % method for setting a location for GBQ client 
        function gbq = setLocation(gbqclient,location)
            % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            
            if ~ isa(gbqclient,'gcp.bigquery.BigQuery')
                write(logObj,'error','Input BigQuery Object was of an unexpected class ');
            else
                gbqJ = gbqclient.Handle;
                gbqOptionsJ = gbqJ.getOptions;
                gbqOptions = gcp.bigquery.BigQueryOptions(gbqOptionsJ);
                gbqOptionsBuilder = gbqOptions.newBuilder;
                gbqOptionsBuilder = gbqOptionsBuilder.setLocation(location);
                gbqOptions = gbqOptionsBuilder.build;
                gbqOptionsJ = gbqOptions.Handle;
                
                % Use the BigQueryOptions.getService() function to create the authenticated BigQuery client.
                gbqJ = gbqOptionsJ.getService;
                
                % Wrap the java object gbqJ to MATLAB class object gbq
                gbq = gcp.bigquery.BigQuery(gbqJ);
            end
        end
    end %methods
    
end %class