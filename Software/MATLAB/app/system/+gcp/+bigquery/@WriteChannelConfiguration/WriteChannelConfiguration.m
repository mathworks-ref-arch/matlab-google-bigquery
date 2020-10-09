classdef WriteChannelConfiguration  < gcp.bigquery.Object
% WRITECHANNELCONFIGURATION Google BigQuery Configuration for a load operation. 
%
% A load configuration can be used to load data into a table with a WriteChannel (BigQuery.writer(WriteChannelConfiguration)).
% This class is in implicit usage within the function "copyfiletobigquery"
%
% Usage
% 
%   % Set configurations such as formatOption and detection of format overwriting permissions
%   % and others while loading data from any source to a bigquery table
%
%       writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setFormatOptions(formatOptions);
%       writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setAutodetect(java.lang.Boolean(1));
%   
%   % Settings for creating a table if none exist and overwriting/appending to a table if it already exists 
%
%       createDispositionConfig = gcp.bigquery.JobInfo.CreateDisposition.valueOf(createdisposition);
%       writeDispositionConfig = gcp.bigquery.JobInfo.WriteDisposition.valueOf(writedisposition);
%   
%   % Assign the above settings of create and write disposition to the writeChannelCongfigurationBuilder
%
%       writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setCreateDisposition(createDispositionConfig);
%       writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setWriteDisposition(writeDispositionConfig);
% 
%   % Build the above config 
%
%       writeChannelConfiguration = writeChannelConfigurationBuilder.build;
%
%   % Create a writer object using the above configuration
%
%       writer = gbq.Handle.writer(writeChannelConfiguration.Handle);
%
%   % Create channel stream for writer to write in
%      
%      import java.nio.channels.Channels
%      stream = Channels.newOutputStream(writer);
%     
%   % Get file path to the local source
%   
%       import java.nio.file.FileSystems
%       path = which(filename);
%       splits = strsplit(path,filesep);
%       fileartifact = splits{end};
%       pathartifact = fullfile(splits{1:end-1});
%       javafilepath = FileSystems.getDefault().getPath(pathartifact,fileartifact);
%     
%    % Run file copy job
%       import java.nio.file.Files
%       Files.copy(javafilepath, stream);
%     
%    % Close writer
%       writer.close
%     
%     % Get Job handle for the bigquery copy job
%     job = writer.getJob();

%                 (c) 2020 MathWorks, Inc. 

properties
end

methods
	%% Constructor 
	function obj = WriteChannelConfiguration(varargin)
    % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
 
     % Verify class of the object
        if ~ isa(varargin{1},'com.google.cloud.bigquery.WriteChannelConfiguration')
            write(logObj,'error','WriteChannelConfiguration Object creation failed');
        else
            obj.Handle = varargin{1};
        end
	end
end

methods (Static)
    
    %Creates a builder for a BigQuery Load Configuration given the destination table and(or) format.
    function WriteChannelConfigurationBuilder = newBuilder(varargin)
        if isequal(nargin,1)
            
            tableId = varargin{1}.Handle;
            
            % Creates a builder for a BigQuery Load Configuration given the destination table.
            WriteChannelConfigurationBuilderJ = javaMethod('newBuilder','com.google.cloud.bigquery.WriteChannelConfiguration',tableId);
            
            % Wraps Java object into a MATLAB object using the constructor
            WriteChannelConfigurationBuilder = gcp.bigquery.WriteChannelConfiguration.Builder(WriteChannelConfigurationBuilderJ);
       
        elseif isequal(nargin,2)
        
            tableId = varargin{1}.Handle;
            formatOptions = varargin{2}.Handle;
        
            % Creates a builder for a BigQuery Load Configuration given the
            % destination table using inputs such as tableId and
            % formatOptions object created from the source file format
            WriteChannelConfigurationBuilderJ = javaMethod('newBuilder','com.google.cloud.bigquery.WriteChannelConfiguration',tableId,formatOptions);
            
            % Wrap Java object into a MATLAB class object with the
            % constructor
            WriteChannelConfigurationBuilder = gcp.bigquery.WriteChannelConfiguration.Builder(WriteChannelConfigurationBuilderJ);
        else
            % Expected input arguments to be either 1 or 2
            warning('Incorrect number of input arguments');
        end
        
    end
    
    %Returns a BigQuery Load Configuration for the given destination table and(or) format.
    function WriteChannelConfiguration = of(varargin)
        if isequal(nargin,1)
            
            tableId = varargin{1}.Handle;
            
            % Returns a BigQuery Load Configuration for the given destination table.
            WriteChannelConfigurationJ = javaMethod('of','com.google.cloud.bigquery.WriteChannelConfiguration',tableId);
            
            % Wrap Java object into a MATLAB class object with the
            % constructor 
            WriteChannelConfiguration = gcp.bigquery.WriteChannelConfiguration(WriteChannelConfigurationJ);
       
        elseif isequal(nargin,2)
        
            tableId = varargin{1}.Handle;
            formatOptions = varargin{2}.Handle;
            
            % Returns a BigQuery Load Configuration for the given
            % destination table and source file format
            WriteChannelConfigurationJ = javaMethod('of','com.google.cloud.bigquery.WriteChannelConfiguration',tableId,formatOptions);
            
            % Wrap Java object into a MATLAB class object with the
            % constructor
            WriteChannelConfiguration = gcp.bigquery.WriteChannelConfiguration(WriteChannelConfigurationJ);
        else
            % Expected input arguments to be either 1 or 2
            warning('Incorrect number of input arguments');
        end
    end
end

end %class

% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/WriteChannelConfiguration.html
%
% Supported Java Methods
% ----------------------
% static WriteChannelConfiguration.Builder	newBuilder(TableId destinationTable)
% Creates a builder for a BigQuery Load Configuration given the destination table.
%
% static WriteChannelConfiguration.Builder	newBuilder(TableId destinationTable, FormatOptions format)
% Creates a builder for a BigQuery Load Configuration given the destination table and format.
%
% static WriteChannelConfiguration	of(TableId destinationTable)
% Returns a BigQuery Load Configuration for the given destination table.
%
% static WriteChannelConfiguration	of(TableId destinationTable, FormatOptions format)
% Returns a BigQuery Load Configuration for the given destination table and format.