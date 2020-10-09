classdef Table  < gcp.bigquery.Object
% TABLE A Google BigQuery Table.


%                 (c) 2020 MathWorks, Inc. 


properties
end

methods
	%% Constructor 
	function obj = Table(varargin)
        % Setting up Logger for this class
        logObj = Logger.getLogger();
        logObj.MsgPrefix = 'GCP:GBQ';
        
        if ~ isa(varargin{1},'com.google.cloud.bigquery.Table')
            write(logObj,'error','Table Object creation failed');
        else
            obj.Handle = varargin{1};
            write(logObj,'debug','Table Handle created');
        end
    end
    
end


end %class