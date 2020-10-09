function tf = exists(tableobj, varargin)
% EXISTS Method - checks if current table exists
%
%  tf = gbqtable.exists()

%                 (c) 2020 MathWorks, Inc.

%% Implementation       

% Imports
import com.google.cloud.bigquery.*;

% Set Logger
logObj = Logger.getLogger();
logObj.MsgPrefix = 'GCP:GBQ';

% Access Table Handle
tableJ = tableobj.Handle;

% Check for table
tf = tableJ.exists();

if tf
    fprintf("\nTable exists\n");
else
    fprintf("\nTable does not exist\n");
end
end %function
