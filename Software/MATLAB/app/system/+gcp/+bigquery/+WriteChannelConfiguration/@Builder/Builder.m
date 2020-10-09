classdef Builder < gcp.bigquery.Object
%BUILDER A builder for WriteChannelConfiguration objects.
%
%   WriteChannelConfiguration.Builder is used to set configuration for
%   writing data to BigQuery Tables
%   
%
% Usage (implicitly used by +gcp/+bigquery/@WriteChannelConfiguration)
%
%  WriteChannelConfigurationBuilder = gcp.bigquery.WriteChannelConfiguration.newBuilder(TableId);
%  WriteChannelConfigurationBuilder = WriteChannelConfigurationBuilder.setAutodetect(true);
%  WriteChannelConfigurationBuilder = WriteChannelConfigurationBuilder.setWriteDisposition('WRITE_APPEND');
%  WriteChannelConfiguration = WriteChannelConfigurationBuilder.build;
%

%                 (c) 2020 MathWorks, Inc.
    properties
        
    end
    
    methods
        
        function obj = Builder(varargin)
            % Setting up Logger for this class
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GBQ';
            
            % Verify class of input object before assigning to the Handle
            if ~ isa(varargin{1},'com.google.cloud.bigquery.WriteChannelConfiguration$Builder')
                write(logObj,'error','WriteChannelConfiguration.Builder Object creation failed');
            else
                obj.Handle = varargin{1};
            end
        end
        
        % Build the Builder configuration for writer
        function WriteChannelConfiguration = build(obj)
            WriteChannelConfigurationBuilderJ = obj.Handle;
            WriteChannelConfigurationJ = WriteChannelConfigurationBuilderJ.build;
            
            % Wrap Java class object WriteChannelConfigurationJ into MATLAB class object WriteChannelConfiguration 
            WriteChannelConfiguration = gcp.bigquery.WriteChannelConfiguration(WriteChannelConfigurationJ);
        end
        
        % Sets automatic inference of the options and schema for CSV and JSON sources
        function WriteChannelConfigurationBuilder = setAutodetect(obj,autodetect)
            WriteChannelConfigurationBuilderJ = obj.Handle;
            WriteChannelConfigurationBuilderJ = WriteChannelConfigurationBuilderJ.setAutodetect(autodetect);
            
            % Wrap Java class object WriteChannelConfigurationJ into MATLAB class object WriteChannelConfiguration           
            WriteChannelConfigurationBuilder = gcp.bigquery.WriteChannelConfiguration.Builder(WriteChannelConfigurationBuilderJ);
        end
        
        % Sets the destination table to load the data into.
        function WriteChannelConfigurationBuilder = setDestinationTable(obj,TableId)
            WriteChannelConfigurationBuilderJ = obj.Handle;
            WriteChannelConfigurationBuilderJ = WriteChannelConfigurationBuilderJ.setDestinationTable(TableId.Handle);

            % Wrap Java class object WriteChannelConfigurationJ into MATLAB class object WriteChannelConfiguration
            WriteChannelConfigurationBuilder = gcp.bigquery.WriteChannelConfiguration.Builder(WriteChannelConfigurationBuilderJ);
        end
        
       % Sets the source format, and possibly some parsing options, of the external data.  
        function WriteChannelConfigurationBuilder = setFormatOptions(obj,FormatOptions)
            WriteChannelConfigurationBuilderJ = obj.Handle;
            WriteChannelConfigurationBuilderJ = WriteChannelConfigurationBuilderJ.setFormatOptions(FormatOptions.Handle);
            
            % Wrap Java class object WriteChannelConfigurationJ into MATLAB class object WriteChannelConfiguration
            WriteChannelConfigurationBuilder = gcp.bigquery.WriteChannelConfiguration.Builder(WriteChannelConfigurationBuilderJ);
        end
        
        % Sets the action that should occur if the destination table already exists.
        function WriteChannelConfigurationBuilder = setWriteDisposition(obj,writeDisposition)
            WriteChannelConfigurationBuilderJ = obj.Handle;
            WriteChannelConfigurationBuilderJ = WriteChannelConfigurationBuilderJ.setWriteDisposition(writeDisposition.Handle);
            
            % Wrap Java class object WriteChannelConfigurationJ into MATLAB class object WriteChannelConfiguration
            WriteChannelConfigurationBuilder = gcp.bigquery.WriteChannelConfiguration.Builder(WriteChannelConfigurationBuilderJ);
        end
        
        % Sets whether the job is allowed to create new tables.
        function WriteChannelConfigurationBuilder = setCreateDisposition(obj,createDisposition)
            WriteChannelConfigurationBuilderJ = obj.Handle;
            WriteChannelConfigurationBuilderJ = WriteChannelConfigurationBuilderJ.setCreateDisposition(createDisposition.Handle);
            
            % Wrap Java class object WriteChannelConfigurationJ into MATLAB class object WriteChannelConfiguration
            WriteChannelConfigurationBuilder = gcp.bigquery.WriteChannelConfiguration.Builder(WriteChannelConfigurationBuilderJ);
        end
    end
end

%% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/WriteChannelConfiguration.html
%
% Supported Methods:
% ------------------
%
% WriteChannelConfiguration	build() 
% Returns built object
%
% WriteChannelConfiguration.Builder	setAutodetect(Boolean autodetect)
% [Experimental] Sets automatic inference of the options and schema for CSV and JSON sources.
%
% WriteChannelConfiguration.Builder	setCreateDisposition(JobInfo.CreateDisposition createDisposition)
% Sets whether the job is allowed to create new tables.
%
% WriteChannelConfiguration.Builder	setDestinationTable(TableId destinationTable)
% Sets the destination table to load the data into.
%
% WriteChannelConfiguration.Builder	setFormatOptions(FormatOptions formatOptions)
% Sets the source format, and possibly some parsing options, of the external data.
%
% WriteChannelConfiguration.Builder	setWriteDisposition(JobInfo.WriteDisposition writeDisposition)
% Sets the action that should occur if the destination table already exists.
%
%% Unsupported Methods:
% --------------------
%
% WriteChannelConfiguration.Builder	setClustering(Clustering clustering)
% Sets the clustering specification for the destination table.
%
% WriteChannelConfiguration.Builder	setSchemaUpdateOptions(List<JobInfo.SchemaUpdateOption> schemaUpdateOptions)
% [Experimental] Sets options allowing the schema of the destination table to be updated as a side effect of the load job.
%
% WriteChannelConfiguration.Builder	setTimePartitioning(TimePartitioning timePartitioning)
% Sets the time partitioning specification for the destination table.
%
% WriteChannelConfiguration.Builder	setUseAvroLogicalTypes(Boolean useAvroLogicalTypes)
% If FormatOptions is set to AVRO, you can interpret logical types into their corresponding types (such as TIMESTAMP) instead of only using their raw types (such as INTEGER).
%
% LoadConfiguration.Builder	setDestinationEncryptionConfiguration(EncryptionConfiguration encryptionConfiguration) 
%
% WriteChannelConfiguration.Builder	setIgnoreUnknownValues(Boolean ignoreUnknownValues)
% Sets whether BigQuery should allow extra values that are not represented in the table schema.
%
% WriteChannelConfiguration.Builder	setMaxBadRecords(Integer maxBadRecords)
% Sets the maximum number of bad records that BigQuery can ignore when running the job.
%
% WriteChannelConfiguration.Builder	setNullMarker(String nullMarker)
% Sets the string that represents a null value in a CSV file.
%
% WriteChannelConfiguration.Builder	setSchema(Schema schema)
% Sets the schema for the destination table.