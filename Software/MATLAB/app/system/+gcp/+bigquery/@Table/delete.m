function tf = delete(tableobj)
% DELETE Method - deletes current table
%
%  tf = gbqtable.delete()

%                 (c) 2020 MathWorks, Inc.

%% Implementation       

% Imports
import com.google.cloud.bigquery.*;

% Set Logger
logObj = Logger.getLogger();
logObj.MsgPrefix = 'GCP:GBQ';

% Access Table Handle
tableJ = tableobj.Handle;

% Delete table
tf = tableJ.delete();

if tf
    fprintf("\nTable deleted successfully\n");
else
    fprintf("\nTable not deleted successfully\n");
end
end %function
