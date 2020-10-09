classdef TableInfo  < gcp.bigquery.Object
% TABLEINFO Google BigQuery table information.
%   
% Usage
%   
%    
%   % Create Table definition:
%           StandardTableDefinitionBuilder = gcp.bigquery.StandardTableDefinition.newBuilder();
%           StandardTableDefinition = StandardTableDefinitionBuilder.build();
%
%   % Create TableInfo
%        tableInfo = of(tableId,StandardTableDefinitio)

%                 (c) 2020 MathWorks, Inc. 


properties
end

methods
	%% Constructor 
    function obj = TableInfo(varargin)
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Validating class of the object before assigning it as Handle
        if ~ isa(varargin{1},'com.google.cloud.bigquery.TableInfo')
            write(logObj,'error','TableInfo Object creation failed');
        else
            obj.Handle = varargin{1};
        end
        
    end
end

methods (Static)
    function tableInfo = of(tableId,TableDefinition)
        
        import com.google.cloud.bigquery.*;
        
        % Create TableInfo with tnput arguments such as TableId and the
        % TableDefinition
        tableInfoJ = javaMethod('of','com.google.cloud.bigquery.TableInfo',tableId.Handle,TableDefinition.Handle);
        
        % Wraps Java object tableInfoJ into a MATLAB class object TableInfo
        % using the constructor
        tableInfo = gcp.bigquery.TableInfo(tableInfoJ);
    end
end

end %class