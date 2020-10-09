classdef TableOption  < gcp.bigquery.Object
% TABLEOPTION Specifies options for querying Table fields
%   
% 
% Usage
% 
%           fields = gcp.bigquery.BigQuery.TableField.valueOf('ID','LOCATION') % returns all Table fields
%           TableOption = gcp.bigquery.BigQuery.TableOption.fields(fields)

%                 (c) 2020 MathWorks, Inc. 

properties
end

methods
	%% Constructor 
	function obj = TableOption(varargin)
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        % Checking class before Handle assignment
        if ~ isa(varargin{1},'com.google.cloud.bigquery.BigQuery$TableOption')
            write(logObj,'error','TableOption Object creation failed');
        else
            obj.Handle = varargin{1};
        end
	end
end

methods(Static)
    
    % Returns an option to specify the table's fields to be returned by the RPC call.
    function TableOption = fields(fields)
        
        % Imports
        import com.google.cloud.bigquery.BigQuery;
        
        % Creating TableOption. Required TableField object as input
        TableOptionJ = javaMethod('fields','com.google.cloud.bigquery.BigQuery$TableOption', fields.Handle);
        
        % Wrapping into a MATLAB class object
        TableOption = gcp.bigquery.BigQuery.TableOption(TableOptionJ);

    end
    
end % methods(Static)

end %class

% Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/bigquery/BigQuery.TableOption.html
%
% Java API options
%--------------------
% static BigQuery.TableOption	fields(BigQuery.TableField... fields)
% Returns an option to specify the table's fields to be returned by the RPC call.
