classdef Builder < gcp.bigquery.Object
%BUILDER A builder for LoadJobConfiguration objects.
%
% LoadJobConfiguration.Builder is used to set configuration for writing data
% to BigQuery Tables from external sources such as Google Cloud Storage
%   
% Usage (implicitly used by +gcp/+bigquery/@LoadJobConfiguration)
%
%  LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.newBuilder(tableId,sourceUri,formatOptions);
%  LoadJobConfigurationBuilder = LoadJobConfigurationBuilder.setAutodetect(java.lang.Boolean(1));
%  LoadJobConfigurationBuilder = LoadJobConfigurationBuilder.setCreateDisposition('CREATE_IF_NEEDED');
%  LoadJobConfiguration = LoadJobConfigurationBuilder.build;
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
            if ~ isa(varargin{1},'com.google.cloud.bigquery.LoadJobConfiguration$Builder')
                write(logObj,'error','LoadJobConfiguration.Builder object creation failed');
            else
                obj.Handle = varargin{1};
            end
        end
        
        % Creates a LoadJobConfiguration object
        function LoadJobConfiguration = build(obj)
            LoadJobConfigurationBuilderJ = obj.Handle;
            LoadJobConfigurationJ = LoadJobConfigurationBuilderJ.build;
            LoadJobConfiguration = gcp.bigquery.LoadJobConfiguration(LoadJobConfigurationJ);
        end
        
        % Sets automatic inference of the options and schema for CSV and JSON sources.
        function LoadJobConfigurationBuilder = setAutodetect(obj,autodetect)
            LoadJobConfigurationBuilderJ = obj.Handle;
            LoadJobConfigurationBuilderJ = LoadJobConfigurationBuilderJ.setAutodetect(autodetect);
            LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.Builder(LoadJobConfigurationBuilderJ);
        end
        
        
        % Sets the tableId for the destination table.
        function LoadJobConfigurationBuilder = setDestinationTable(obj,tableId)
            LoadJobConfigurationBuilderJ = obj.Handle;
            LoadJobConfigurationBuilderJ = LoadJobConfigurationBuilderJ.setDestinationTable(tableId.Handle);
            LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.Builder(LoadJobConfigurationBuilderJ);
        end
        
        % Sets the source format, and possibly some parsing options, of the external data.
        function LoadJobConfigurationBuilder = setFormatOptions(obj,FormatOptions)
            LoadJobConfigurationBuilderJ = obj.Handle;
            LoadJobConfigurationBuilderJ = LoadJobConfigurationBuilderJ.setFormatOptions(FormatOptions.Handle);
            LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.Builder(LoadJobConfigurationBuilderJ);
        end
        
        % Sets whether the job is allowed to create new tables.
        function LoadJobConfigurationBuilder = setCreateDisposition(obj,CreateDisposition)
            LoadJobConfigurationBuilderJ = obj.Handle;
            LoadJobConfigurationBuilderJ = LoadJobConfigurationBuilderJ.setCreateDisposition(CreateDisposition.Handle);
            LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.Builder(LoadJobConfigurationBuilderJ);
        end
        
        % Sets the action that should occur if the destination table already exists
        function LoadJobConfigurationBuilder = setWriteDisposition(obj,WriteDisposition)
            LoadJobConfigurationBuilderJ = obj.Handle;
            LoadJobConfigurationBuilderJ = LoadJobConfigurationBuilderJ.setWriteDisposition(WriteDisposition.Handle);
            LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.Builder(LoadJobConfigurationBuilderJ);
        end
    end
end

%% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/LoadJobConfiguration.Builder.html
%
% Supported Java APIs
% --------------------
% LoadJobConfiguration	build()
% Creates an object.
% 
% LoadJobConfiguration.Builder	setAutodetect(Boolean autodetect)
% [Experimental] Sets automatic inference of the options and schema for CSV and JSON sources.
% 
% LoadJobConfiguration.Builder	setCreateDisposition(JobInfo.CreateDisposition createDisposition)
% Sets whether the job is allowed to create new tables.
% 
% LoadJobConfiguration.Builder	setDestinationTable(TableId destinationTable)
% Sets the destination table to load the data into.
% 
% LoadJobConfiguration.Builder	setFormatOptions(FormatOptions formatOptions)
% Sets the source format, and possibly some parsing options, of the external data.
% 
% LoadJobConfiguration.Builder	setWriteDisposition(JobInfo.WriteDisposition writeDisposition)
% Sets the action that should occur if the destination table already exists.
%
%% Unsupported methods
%  -------------------
% LoadJobConfiguration.Builder	setClustering(Clustering clustering)
% Sets the clustering specification for the destination table.
%
% LoadJobConfiguration.Builder	setSchemaUpdateOptions(List<JobInfo.SchemaUpdateOption> schemaUpdateOptions)
% [Experimental] Sets options allowing the schema of the destination table to be updated as a side effect of the load job.
% 
% LoadJobConfiguration.Builder	setSourceUris(List<String> sourceUris)
% Sets the fully-qualified URIs that point to source data in Google Cloud Storage
% 
% LoadJobConfiguration.Builder	setTimePartitioning(TimePartitioning timePartitioning)
% Sets the time partitioning specification for the destination table.
% 
% LoadJobConfiguration.Builder	setUseAvroLogicalTypes(Boolean useAvroLogicalTypes)
% If FormatOptions is set to AVRO, you can interpret logical types into their corresponding types (such as TIMESTAMP) instead of only using their raw types (such as INTEGER).
% 
% LoadJobConfiguration.Builder	setJobTimeoutMs(Long jobTimeoutMs)
% [Optional] Job timeout in milliseconds.
% 
% LoadJobConfiguration.Builder	setLabels(Map<String,String> labels)
% The labels associated with this job.
% 
% LoadJobConfiguration.Builder	setMaxBadRecords(Integer maxBadRecords)
% Sets the maximum number of bad records that BigQuery can ignore when running the job.
% 
% LoadJobConfiguration.Builder	setNullMarker(String nullMarker)
% Sets the string that represents a null value in a CSV file.
% 
% LoadJobConfiguration.Builder	setRangePartitioning(RangePartitioning rangePartitioning)
% Range partitioning specification for this table.
%
% LoadJobConfiguration.Builder	setDestinationEncryptionConfiguration(EncryptionConfiguration encryptionConfiguration) 
%
% LoadJobConfiguration.Builder	setIgnoreUnknownValues(Boolean ignoreUnknownValues)
% Sets whether BigQuery should allow extra values that are not represented in the table schema.
%
% LoadJobConfiguration.Builder	setSchema(Schema schema)
% Sets the schema for the destination table.