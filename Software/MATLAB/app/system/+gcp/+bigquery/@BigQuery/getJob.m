function Job = getJob(gbq, varargin) 
% GETJOB Method to request an existing job using the jobid
%
% Usage
%
%       gbq = gcp.bigquery.BigQuery('credentials.json')
%       job = gbq.getJob(jobId); ,where jobId is of type "gcp.bigquery.JobId"
%
%          or
%
%       job = gbq.getJob("jobId"); , where jobId is of type string or char

%                 (c) 2020 MathWorks, Inc.

% Imports
import com.google.cloud.bigquery.*;

% Set Logger
logObj = Logger.getLogger();
logObj.MsgPrefix = 'GCP:GBQ';

if ~isequal(numel(varargin),1)
    write(logObj,'error','Unexpected number of Inputs');
else
    % Check for GBQ client
    if ~ isa(gbq,'gcp.bigquery.BigQuery')
        write(logObj,'error','Expecting an object of class gcp.bigquery.BigQuery');
    else
        gbqJ = gbq.Handle;
        if ~ isa(gbqJ,'com.google.cloud.bigquery.BigQueryImpl')
            write(logObj,'error','Expecting an object of class com.google.cloud.bigquery.BigQueryImpl');
        else
            jobField = gcp.bigquery.BigQuery.JobField.values;
            jobOption = gcp.bigquery.BigQuery.JobOption.fields(jobField);
            jobOptions = javaArray('com.google.cloud.bigquery.BigQuery$JobOption',1);
            jobOptions(1) = jobOption.Handle;
            
            switch(class(varargin{1}))
                case 'string'
                    jobId = string(varargin{1}); %string
                    Job = gcp.bigquery.Job(gbqJ.getJob(jobId,jobOptions));
                case 'char'
                    jobId = string(varargin{1}); %string
                    Job = gcp.bigquery.Job(gbqJ.getJob(jobId,jobOptions));
                case 'gcp.bigquey.JobId'
                    jobIdJ = varargin{1}.Handle;
                    Job = gcp.bigquery.Job(gbqJ.getJob(jobIdJ,jobOptions));
                otherwise
                    write(logObj,'error','Expected input is JobId of class string or class gcp.bigquery.JobId');
            
            end % switch - check class of JobId
            
        end % if - check class of gbq Handle
        
    end % if - check class of obj
    
end % if - check number of inputs

end %function