function job = load(gbqtable, varargin)
% LOAD Starts a BigQuery Job to load data into the current table from the provided source URIs.
%   
% For instance, loading data from Google cloud storage bucket
%
% Input Arguments:
%    *  bigquery table
%    *  format of the source file (See FormatOptions for more details)
%    *  source Uri e.g. "gs://my_bucket/filename1.csv"
%    *  Job Option

%                 (c) 2020 MathWorks, Inc.

% Get the Handle to the Java object Table
gbqtableJ = gbqtable.Handle;

% Getting Inut arguments formatOptions, sourceUri for source data and
% configuration for running the load job within jobOptions
formatOptions = varargin{1}.Handle;
sourceUri = varargin{2};
jobOption = varargin{3}.Handle;

% Creating an array for the job options
jobOptionArray = javaArray('com.google.cloud.bigquery.BigQuery$JobOption',1);
jobOptionArray(1) = jobOption;

% Invoke the load job to load the table with the source data
jobJ = gbqtableJ.load(formatOptions,sourceUri,jobOptionArray);

% Wrapping the job into a MATLAB object gcp.bigquery.Job and returning
job = gcp.bigquery.Job(jobJ);

end %function

