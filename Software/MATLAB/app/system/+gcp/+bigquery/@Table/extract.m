function extract(table, varargin)
% EXTRACT Method - Starts a BigQuery Job to extract the current table to the provided destination URI. Returns the started Job object.
%
%  filename = "mydata.csv";
%  gcsbucketname = "my_bucket";
%  job = table.extract(filename, gcsbucketname);

%                 (c) 2020 MathWorks, Inc.

%% Implementation        

% Imports
import com.google.cloud.bigquery.*;

% Set Logger
logObj = Logger.getLogger();
logObj.MsgPrefix = 'GCP:GBQ';

% Access Table Handle
tableJ = table.Handle;

% File format to be saved as blob on google bucket e.g. csv, NewLineJSON
filename = string(varargin{1});
filesplits = strsplit(filename,".");
extension = filesplits(end);
switch extension
    case "csv"
        format = 'CSV'; %CSV, NEWLINE_DELIMITED_JSON and AVRO
    case "avro"
        format = 'AVRO';
    case "json"
        format = 'NEWLINE_DELIMITED_JSON';
    otherwise
        write(logObj,'error','');
end
       
% url format: ['gs://',bucket,'/',file])
bucketname = string(varargin{2});

% Bucket Url e.g. gs://bucketname-for-example
destinationUri = strcat("gs://",bucketname,"/",filename);

% Create JobOption
jobFields = gcp.bigquery.BigQuery.JobField.values;
jobOption = gcp.bigquery.BigQuery.JobOption.fields(jobFields);
jobOptions = javaArray('com.google.cloud.bigquery.BigQuery$JobOption',1);
jobOptions(1) = jobOption.Handle;

% Create job for extracting table to Google Cloud Storage bucket
job = gcp.bigquery.Job(tableJ.extract(format,destinationUri,jobOptions));

% Wait for Job to complete
job.waitFor

end %function

% Java API implemented above
%
% public Job extract(String format,
%                    String destinationUri,
%                    BigQuery.JobOption... options)