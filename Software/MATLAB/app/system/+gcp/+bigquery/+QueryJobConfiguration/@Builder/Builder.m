classdef Builder < gcp.bigquery.Object
%BUILDER A builder for JobConfiguration objects.
%
%   QueryJobconfiguration.Builder is used to set query configuration such
%   as defaultdataset, destinationtable, querytype, size of queryresults, create disposition and writedisposition.
%
%   Usage 
%
%       QueryJobConfigurationBuilder = newBuilder(query);
%       (optional) QueryJobConfigurationBuilder = QueryJobConfigurationBuilder.setAllowLargeResults([TRUE/FALSE])
%       (optional) QueryJobConfigurationBuilder = QueryJobConfigurationBuilder.setUseLegacySql([TRUE/FALSE])
%       (optional) QueryJobConfigurationBuilder = QueryJobConfigurationBuilder.setQuery(query)
%       (optional) QueryJobConfigurationBuilder = QueryJobConfigurationBuilder.setDestinationTable(tableId)
%       (optional) QueryJobConfigurationBuilder = QueryJobConfigurationBuilder.setDefaultDatset(datasetid);
%       (optional) QueryJobConfigurationBuilder = QueryJobConfigurationBuilder.setCreateDisposition(createdisposition);
%       (optional) QueryJobConfigurationBuilder = QueryJobConfigurationBuilder.setWriteDisposiion(writedisposition);
%       QueryJobConfiguration = QueryJobConfigurationBuilder.build;
%

%                 (c) 2020 MathWorks, Inc.
    properties
        
    end
    
    methods
        function obj = Builder(varargin)
            % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            
            % Checking for class of returned object before Handle
            % assignement
            if ~ isa(varargin{1},'com.google.cloud.bigquery.QueryJobConfiguration$Builder')
                write(logObj,'error','QueryJobConfiguration.Builder object creation failed');
            else
                obj.Handle = varargin{1};
            end
        end
        
     
        function queryJobConfiguration = build(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            queryJobConfigurationBuilder = obj.Handle;
            queryJobConfigurationJ = queryJobConfigurationBuilder.build;
            queryJobConfiguration = gcp.bigquery.QueryJobConfiguration(queryJobConfigurationJ);
        end
        
        %   QueryJobConfiguration.Builder	setAllowLargeResults(Boolean allowLargeResults)
        %   Sets whether the job is enabled to create arbitrarily large results.
        function queryJobConfigurationBuilder = setAllowLargeResults(obj,allowLargeResults)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            queryJobConfigurationBuilderJ = obj.Handle;
            allowLargeResults = javaObject('java.lang.Boolean',allowLargeResults);
            queryJobConfigurationBuilderJ = queryJobConfigurationBuilderJ.setAllowLargeResults(allowLargeResults);
            queryJobConfigurationBuilder = gcp.bigquery.QueryJobConfiguration.Builder(queryJobConfigurationBuilderJ);
        end
        
        %   QueryJobConfiguration.Builder	setQuery(String query)
        %   Sets the BigQuery SQL query to execute.
        function queryJobConfigurationBuilder =setQuery(obj, query)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            queryJobConfigurationBuilderJ = obj.Handle;
            queryJobConfigurationBuilderJ = queryJobConfigurationBuilderJ.setQuery(query);
            queryJobConfigurationBuilder = gcp.bigquery.QueryJobConfiguration.Builder(queryJobConfigurationBuilderJ);
        end
        
%       QueryJobConfiguration.Builder	setUseLegacySql(Boolean useLegacySql)
%       Sets whether to use BigQuery's legacy SQL dialect for this query.
        function queryJobConfigurationBuilder = setUseLegacySql(obj,useLegacySql)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            queryJobConfigurationBuilderJ = obj.Handle;
            useLegacySql = javaObject('java.lang.Boolean',useLegacySql);
            queryJobConfigurationBuilderJ = queryJobConfigurationBuilderJ.setUseLegacySql(useLegacySql);
            queryJobConfigurationBuilder = gcp.bigquery.QueryJobConfiguration.Builder(queryJobConfigurationBuilderJ);
        end
        
        % sets destination table
        function queryJobConfigurationBuilder = setDestinationTable(obj,tableId)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            queryJobConfigurationBuilderJ = obj.Handle;
            queryJobConfigurationBuilderJ = queryJobConfigurationBuilderJ.setDestinationTable(tableId.Handle);
            queryJobConfigurationBuilder = gcp.bigquery.QueryJobConfiguration.Builder(queryJobConfigurationBuilderJ);
        end
        
%         QueryJobConfiguration.Builder	setDefaultDataset(String defaultDataset)
%         Sets the default dataset.
        function QueryJobConfigurationBuilder = setDefaultDataset(obj,defaultDataset)
            QueryJobConfigurationBuilderJ = obj.Handle;
            if isa(defaultDataset,'string')
                QueryJobConfigurationBuilderJ = QueryJobConfigurationBuilderJ.setDefaultDataset(defaultDataset);
            elseif isa(defaultDataset,'gcp.bigquery.DatasetId')
                QueryJobConfigurationBuilderJ = QueryJobConfigurationBuilderJ.setDefaultDataset(defaultDataset.Handle);             
            else
                warning('Incorrect class for DatasetId. It should be either string or gcp.bigquery.DatasetId');
            end
            QueryJobConfigurationBuilder = gcp.bigquery.QueryJobConfiguration.Builder(QueryJobConfigurationBuilderJ);
        end 
        
        % setWriteDisposition(JobInfo.WriteDisposition writeDisposition)
        % Sets the action that should occur if the destination table already exists
        function QueryJobConfigurationBuilder = setWriteDisposition(obj,WriteDisposition)
            QueryJobConfigurationBuilderJ = obj.Handle;
            QueryJobConfigurationBuilderJ = QueryJobConfigurationBuilderJ.setWriteDisposition(WriteDisposition.Handle);
            QueryJobConfigurationBuilder = gcp.bigquery.QueryJobConfiguration.Builder(QueryJobConfigurationBuilderJ);
        end

%         QueryJobConfiguration.Builder	setCreateDisposition(JobInfo.CreateDisposition createDisposition)
%         Sets whether the job is allowed to create tables.
        % Sets whether the job is allowed to create new tables.
        function QueryJobConfigurationBuilder = setCreateDisposition(obj,CreateDisposition)
            QueryJobConfigurationBuilderJ = obj.Handle;
            QueryJobConfigurationBuilderJ = QueryJobConfigurationBuilderJ.setCreateDisposition(CreateDisposition.Handle);
            QueryJobConfigurationBuilder = gcp.bigquery.QueryJobConfiguration.Builder(QueryJobConfigurationBuilderJ);
        end
    end
end

