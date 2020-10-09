function jtable = listJobs(gbq, varargin)
% LISTJOBS Method to list the project's jobs
%
% Usage:
%
%   % create gbq client
%   gbq = gcp.bigquery.BigQuery('credentials.json');
%
%   % create options/configs for listing jobs
%   jobListOption1 = ...
%   gcp.bigquery.BigQuery.JobListOption.pageSize/pageToken/parentJobId(input);
%
%   jobList = gbq.listJobs(jobListOption1,....,jobListOptionN);
%

%                 (c) 2020 MathWorks, Inc.

%% Accessing GBQ client Handle
gbqJ = gbq.Handle;

% Create jobListOptions

% Expecting 1 or more jobListOption as input arguments
n = numel(varargin);

% Checking for number of input arguments
if n < 1
    warning('You need to provide atleast one JobListOption');
else
    % Creating array of JobListOptions with n as size
    joblistOptionArray = javaArray('com.google.cloud.bigquery.BigQuery$JobListOption',n);
    
    % cnt is a flag
    cnt = 0;
    
    % Iterate over input arguments
    for i = 1:numel(varargin)
        
        % Check for class of every input argument
        if isa(varargin{i},'gcp.bigquery.BigQuery.JobListOption')
            
            % Assign to array if class of input argument is as expected
            joblistOptionArray(i) = varargin{i}.Handle;
            
            % increment counter - sets flag to true
            cnt = cnt+1;
        else
            % incorrect class of input argument
            warning('Input needs to be of type gcp.bigquery.BigQuery.JobListOption');
        end
        % Array assignment completion
    end
    % Check flag for atleast one assignment to the array
    
    if cnt < 1
        warning('JobtListOptions could not be created due to incorrect input types');
    else
        % List jobs for this project
        joblist = gbqJ.listJobs(joblistOptionArray);
        
        % Iterate over jobs in this project
        joball = joblist.iterateAll;
        
        % Creating iterator
        jobiterator = joball.iterator;
        
        % Table listing Jobs in the project;
        jtable = table;
        % Parsing job list pages
        while jobiterator.hasNext
            cjob = jobiterator.next;
            jobid = cjob.getJobId;
            generationid = cjob.getGeneratedId;
            jtable = vertcat(jtable,table(string(jobid),string(generationid))); %#ok<*AGROW>
        end
        % Check if jobs exist for listing
        if isequal(size(jtable,1),0)
            fprintf('No jobs to list in the project %s',string(datasetId));
        else
            % Setting Column names for table listing job information of this project
            jtable.Properties.VariableNames= {'JobId','GenerationId'};
        end
        
    end %if
    
end % if

end %function
