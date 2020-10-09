classdef QueryJobConfiguration  < gcp.bigquery.Object
% QUERYJOBCONFIGURATION Google BigQuery Query Job configuration. A Query Job runs a query against BigQuery data. 
%   
% Usage:
% 
%    1. Use QueryJobConfiguration.Builder to build configuration for
%       queries with custom options
%
%       query = "SELECT title, comment, contributor_ip, timestamp, num_characters FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0 LIMIT 40;";
%       queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
%       queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setUseLegacySql(logical(1));
%       queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setAllowLargeResults(logical(1));
%       queryJobConfiguration = queryJobConfigurationBuilder.build()
%
%    2. Use QueryJobConfiguration to set default configuration for queries
%
%       query = "SELECT title, comment, contributor_ip, timestamp, num_characters FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0 LIMIT 40;";
%       queryJobConfiguration =  gcp.bigquery.QueryJobConfiguration.of(query);
%

% (c) 2020 MathWorks, Inc. 


properties
end

methods
	%% Constructor 
	function obj = QueryJobConfiguration(varargin)
        
      % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
      % Verify class of the input java class object before
      % wrapping/assigning it as a Handle for MATLAB class object
      % gcp.bigquery.QueryJobConfiguration
        switch (class(varargin{1}))
            case 'com.google.cloud.bigquery.QueryJobConfiguration'
                obj.Handle = varargin{1};
            otherwise
                write(logObj,'error','QueryJobConfiguration Object creation failed');
        end
	end
end

methods(Static)
    
    function QueryJobConfigurationBuilder = newBuilder(query)
        % Imports
        import com.google.cloud.bigquery.*;
        
        % Create QueryJobConfiguration.Builder
        QueryJobConfigurationBuilderJ = javaMethod('newBuilder','com.google.cloud.bigquery.QueryJobConfiguration',query);
        
        % Wrap into a MATLAB class object
        QueryJobConfigurationBuilder = gcp.bigquery.QueryJobConfiguration.Builder(QueryJobConfigurationBuilderJ);
    end
    
    function QueryJobConfiguration = of(query)
        % Imports
        import com.google.cloud.bigquery.*;%QueryJobConfiguration;
        
        % Create default QueryJobConfiguration
        QueryJobConfigurationJ = javaMethod('of','com.google.cloud.bigquery.QueryJobConfiguration',query);
        
        % Wrap into a MATLAB class object
        QueryJobConfiguration = gcp.bigquery.QueryJobConfiguration(QueryJobConfigurationJ);
    end
end

end %class

% Reference : https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/QueryJobConfiguration.html
%
% Java API:
% ---------
% static QueryJobConfiguration.Builder	newBuilder(String query)
% Creates a builder for a BigQuery Query Job given the query to be run.
% 
% static QueryJobConfiguration	of(String query)
% Returns a BigQuery Copy Job for the given the query to be run.