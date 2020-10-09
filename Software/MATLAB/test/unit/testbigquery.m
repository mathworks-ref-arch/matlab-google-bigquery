classdef testbigquery < matlab.unittest.TestCase
    % TESTBIGQUERY Unit tests for the big query object
    
    %                 (c) 2020 MathWorks, Inc.
    properties
        logObj
        gbqclient
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Please add your test cases below
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods  (TestMethodSetup)
        function testSetup(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLevel = 'verbose';
            testCase.gbqclient = gcp.bigquery.BigQuery('credentials.json');
        end
    end
    
    methods (TestMethodTeardown)
        function testTearDown(testCase) %#ok<*MANU>
            
        end
    end
    
    methods (Test)
        %% Test @BigQuery
        function testBigQuery(testCase)
            % Initialization
            testCase.gbqclient = gcp.bigquery.BigQuery('credentials.json');
            testCase.assertEqual(class(testCase.gbqclient),'gcp.bigquery.BigQuery');
        end
        
        function testBigQuerysetLocation(testCase)
            %Initialization
            gbq = gcp.bigquery.BigQuery('credentials.json');
            testCase.assertEqual(class(gbq),'gcp.bigquery.BigQuery');
            % Call setLocation
            gbq = gbq.setLocation('US');
            % Test Object class
            testCase.assertEqual(class(gbq),'gcp.bigquery.BigQuery');
            % Test if Location set correctly
            testCase.assertEqual(gbq.Location,'US');
            
        end
        
        
        %% Test @QueryJobConfiguration, @QueryJobConfiguration.builder, @TableResult, function mattable
        function testQuery(testCase)
            % Create a client
            gbq = testCase.gbqclient;
            
            % Select a test query
            query = "SELECT title, comment, contributor_ip, timestamp, num_characters FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0 LIMIT 40;";
            
            % 1. Use QueryJobConfiguration.Builder to build configuration for
            %    queries with custom options
            
            queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
            queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setUseLegacySql(true);
            % queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setAllowLargeResults(logical(1));
            
            % Verify class of the Object
            testCase.verifyClass(queryJobConfigurationBuilder,'gcp.bigquery.QueryJobConfiguration.Builder');
            
            % Verify class of the Handle
            testCase.verifyClass(queryJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.QueryJobConfiguration$Builder');
            
            % Build queryJobconfiguration
            queryJobConfiguration = queryJobConfigurationBuilder.build();
            
            % Verify class of the Object
            testCase.verifyClass(queryJobConfiguration,'gcp.bigquery.QueryJobConfiguration');
            
            % Verify class of the Handle
            testCase.verifyClass(queryJobConfiguration.Handle,'com.google.cloud.bigquery.QueryJobConfiguration');
            
            % Make the query and receive TableResult
            tableResult = gbq.query(queryJobConfiguration);
            
            % Check if results are empty
            testCase.verifyNotEmpty(tableResult)
            
            % Verify class of the Object TableResult
            testCase.verifyClass(tableResult,'gcp.bigquery.TableResult');
            
            % Verify class of the Handle
            testCase.verifyClass(tableResult.Handle,'com.google.cloud.bigquery.TableResult');
            
            % Get results in a MATLAB table
            result_table = gbq2table(tableResult);
            
            % Verify if empty
            testCase.verifyNotEmpty(result_table);
            
            % Verify height of table
            testCase.verifyEqual(height(result_table),40);
            
            % 2. Use QueryJobConfiguration to set default configuration for queries
            
            % Build queryJobconfiguration without Builder - use the method
            % 'of()' instead
            query = "SELECT corpus FROM `bigquery-public-data.samples.shakespeare` GROUP BY corpus;";
            queryJobConfiguration =  gcp.bigquery.QueryJobConfiguration.of(query);
            
            % Verify class of the Object
            testCase.verifyClass(queryJobConfiguration,'gcp.bigquery.QueryJobConfiguration');
            
            % Verify class of the Handle
            testCase.verifyClass(queryJobConfiguration.Handle,'com.google.cloud.bigquery.QueryJobConfiguration');
            
            % Make the query
            tableResult = gbq.query(queryJobConfiguration);
            
            % Check if results are empty
            testCase.verifyNotEmpty(tableResult)
            
            % Verify class of the Object
            testCase.verifyClass(tableResult,'gcp.bigquery.TableResult');
            
            % Verify class of the Handle
            testCase.verifyClass(tableResult.Handle,'com.google.cloud.bigquery.TableResult');
            
            % Get results in a MATLAB table
            result_table = gbq2table(tableResult);
            
            % Verify if empty
            testCase.verifyNotEmpty(result_table);
            
        end
        
        %% Test @Dataset, @DatasetId, @DatasetInfo and @BigQuery methods listDatasets, getDataset, deletedataset
        function testDataset(testCase)
            % Create a client
            gbq = testCase.gbqclient;
            
            % Access Project id for the service account
            projectid = gbq.ProjectId;
            
            % Create a random dataset name
            datasetname = gcp.bigquery.JobId.createJobId();
            
            % Create a datasetId
            datasetId = gcp.bigquery.DatasetId.of(projectid,datasetname);
            
            % Check if results are empty
            testCase.verifyNotEmpty(datasetId)
            
            % Verify class of the Object
            testCase.verifyClass(datasetId,'gcp.bigquery.DatasetId');
            
            % Verify class of the Handle
            testCase.verifyClass(datasetId.Handle,'com.google.cloud.bigquery.DatasetId');
            
            % Create a random dataset name
            datasetname = gcp.bigquery.JobId.createJobId();
            
            % Create a datasetId
            datasetId = gcp.bigquery.DatasetId.of(datasetname);
            
            % Check if results are empty
            testCase.verifyNotEmpty(datasetId)
            
            % Verify class of the Object
            testCase.verifyClass(datasetId,'gcp.bigquery.DatasetId');
            
            % Verify class of the Handle
            testCase.verifyClass(datasetId.Handle,'com.google.cloud.bigquery.DatasetId');
            
            % Create datasetInfo
            datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);
            
            % Check if results are empty
            testCase.verifyNotEmpty(datasetInfo)
            
            % Verify class of the Object
            testCase.verifyClass(datasetInfo,'gcp.bigquery.DatasetInfo');
            
            % Verify class of the Handle
            testCase.verifyClass(datasetInfo.Handle,'com.google.cloud.bigquery.DatasetInfo');
            
            % Create datasetfields for listing
            datasetField = gcp.bigquery.BigQuery.DatasetField.valuesOf;
            
            % Check if results are empty
            testCase.verifyNotEmpty(datasetField)
            
            % Verify class of the Object
            testCase.verifyClass(datasetField,'gcp.bigquery.BigQuery.DatasetField');
            
            % Verify class of the Handle
            testCase.verifyClass(datasetField.Handle,'com.google.cloud.bigquery.BigQuery$DatasetField[]');
            
            % Create datasetOptions with the fields
            datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField);
            
            % Check if results are empty
            testCase.verifyNotEmpty(datasetOption)
            
            % Verify class of the Object
            testCase.verifyClass(datasetOption,'gcp.bigquery.BigQuery.DatasetOption');
            
            % Verify class of the Handle
            testCase.verifyClass(datasetOption.Handle,'com.google.cloud.bigquery.BigQuery$DatasetOption');
            
            % Create a new dataset
            dataSet = gbq.create(datasetInfo,datasetOption);
            
            % Check if results are empty
            testCase.verifyNotEmpty(dataSet)
            
            % Verify class of the Object
            testCase.verifyClass(dataSet,'gcp.bigquery.Dataset');
            
            % Verify class of the Handle
            testCase.verifyClass(dataSet.Handle,'com.google.cloud.bigquery.Dataset');
            
            % delete the variable dataSet in workspace to test Dataset
            % related methods
            clear dataSet;
            
            % test list datasets
            
            % Create datasetlistOption
            datasetListOption1 = gcp.bigquery.BigQuery.DatasetListOption.all;
            % datasetListOption2 = gcp.bigquery.BigQuery.DatasetListOption.labelFilter(datasetname);
            datasetListOption3 = gcp.bigquery.BigQuery.DatasetListOption.pageSize(10);
            
            % List datasets with different option combination
            list1 = gbq.listDatasets(datasetListOption1);
            % list2 = gbq.listDatasets(datasetListOption2,datasetListOption3)
            list3 = gbq.listDatasets(datasetListOption1,datasetListOption3);
            
            % Check if dataset exists in the list
            
            % getting dataset ids into an array from the above lists list1
            % and list3
            % list 2 is not in use since addlabels to dataset is not a
            % current feature
            datasetidarr1 = list1{:,1};
            datasetidarr3 = list3{:,1};
            
            % test if dataset created above exists in the list1 of
            % datasetids
            tf = any(strcmp(datasetidarr1,datasetname));
            
            % Verify if true
            testCase.verifyTrue(tf);
            
            % test if dataset created above exists in the list3 of
            % datasetids
            tf = any(strcmp(datasetidarr3,datasetname));
            
            % Verify if true
            testCase.verifyTrue(tf);
            
            % Get dataset handle
            testdataSet = gbq.getDataset(datasetname);
            
            % Delete this experimental dataset
            tf = gbq.deleteDataset(datasetname);
            
            %Verify dataset deletion
            testCase.verifyTrue(tf);
            
            % Check if dataset still exists
            tf = testdataSet.exists();
            
            %Verify dataset does not exist as deleted above
            testCase.verifyFalse(tf);
            
            
        end
        
        %% Testing JobId.Builder
        function testJobIdBuilder(testCase)
            %Initialization
            gbq = gcp.bigquery.BigQuery('credentials.json');
            location = 'EU';
            project = gbq.ProjectId;
            jb = gcp.bigquery.JobId.newBuilder;
            jb = jb.setRandomJob();
            jb = jb.setLocation(location);
            jb = jb.setProject(project);
            jobId = jb.build;
            testCase.verifyClass(jobId,'gcp.bigquery.JobId');
        end
        %% Test @JobInfo, @JobId, @Job, @JobField, @JobOption, @TableResult, @Table.extract(), @JobListOption, bigquery.listJobs()
        function testJob(testCase)
            % Create a client
            gbq = testCase.gbqclient;
            
            %% Creating options with which Job should be created
            
            % Create Job Field
            jobField = gcp.bigquery.BigQuery.JobField.values;
            
            % Check if results are empty
            testCase.verifyNotEmpty(jobField)
            
            % Verify class of the Object
            testCase.verifyClass(jobField,'gcp.bigquery.BigQuery.JobField');
            
            % Verify class of the Handle
            testCase.verifyClass(jobField.Handle,'com.google.cloud.bigquery.BigQuery$JobField[]');
            
            % Create Job Field
            jobField = gcp.bigquery.BigQuery.JobField.valueOf('ID','STATUS');
            
            % Check if results are empty
            testCase.verifyNotEmpty(jobField)
            
            % Verify class of the Object
            testCase.verifyClass(jobField,'gcp.bigquery.BigQuery.JobField');
            
            % Verify class of the Handle
            testCase.verifyClass(jobField.Handle,'com.google.cloud.bigquery.BigQuery$JobField[]');
            
            % Create Job Creating Option
            jobOptions = gcp.bigquery.BigQuery.JobOption.fields(jobField);
            
            % Check if results are empty
            testCase.verifyNotEmpty(jobOptions)
            
            % Verify class of the Object
            testCase.verifyClass(jobOptions,'gcp.bigquery.BigQuery.JobOption');
            
            % Verify class of the Handle
            testCase.verifyClass(jobOptions.Handle,'com.google.cloud.bigquery.BigQuery$JobOption');
            
            % Creating Job Id
            randomJobId = gcp.bigquery.JobId.createJobId();
            
            % Check if results are empty
            testCase.verifyNotEmpty(randomJobId)
            
            % Verify class of the Object
            testCase.verifyClass(randomJobId,'char');
            
            % Create a JobId Object using the random jobid created above
            jobId = gcp.bigquery.JobId.of(gbq.ProjectId,randomJobId);
            
            % Check if results are empty
            testCase.verifyNotEmpty(jobId)
            
            % Verify class of the Object
            testCase.verifyClass(jobId,'gcp.bigquery.JobId');
            
            % Verify class of the Handle
            testCase.verifyClass(jobId.Handle,'com.google.cloud.bigquery.AutoValue_JobId');
            
            % Setting properties such as QueryJobconfiguration and JobId for the object JobInfo
            query = "SELECT title, comment, contributor_ip, timestamp, num_characters FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0 LIMIT 40;";
            queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
            queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setUseLegacySql(true);
            queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setAllowLargeResults(true);
            
            % Create a random dataset name
            datasetname = gcp.bigquery.JobId.createJobId();
            % Create a datasetId
            projectid = gbq.ProjectId;
            datasetId = gcp.bigquery.DatasetId.of(projectid,datasetname);
            % Create datasetInfo
            datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);
            % Create datasetfields for listing
            datasetField = gcp.bigquery.BigQuery.DatasetField.valuesOf;
            % Create datasetOptions with the fields
            datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField);
            % Create a new dataset
            dataSet = gbq.create(datasetInfo,datasetOption);
            
            % Set destination dataset and table
            tableId = gcp.bigquery.TableId.of(datasetname,'newtable1');
            queryJobConfigurationBuilder = queryJobConfigurationBuilder.setDestinationTable(tableId);
            queryJobConfiguration = queryJobConfigurationBuilder.build;
            
            % Create JobInfo for the destination table and dataset
            jobInfobuilder = gcp.bigquery.JobInfo.newBuilder(queryJobConfiguration);
            jobInfobuilder = jobInfobuilder.setJobId(jobId);
            jobInfo = jobInfobuilder.build;
            % Check if results are empty
            testCase.verifyNotEmpty(jobInfo)
            
            % Verify class of the Object
            testCase.verifyClass(jobInfo,'gcp.bigquery.JobInfo');
            
            % Verify class of the Handle
            testCase.verifyClass(jobInfo.Handle,'com.google.cloud.bigquery.JobInfo');
            
            % Job creation
            job = gbq.create(jobInfo,jobOptions);
            
            % Check if results are empty
            testCase.verifyNotEmpty(job)
            
            % Verify class of the Object
            testCase.verifyClass(job,'gcp.bigquery.Job');
            
            % Verify class of the Handle
            testCase.verifyClass(job.Handle,'com.google.cloud.bigquery.Job');
            
            % Polling for job completion
            job.waitFor
            
            % Setting options for the way you would want query results to be returned
            queryResultsOption = gcp.bigquery.BigQuery.QueryResultsOption.pageSize(100);
            
            % Check if results are empty
            testCase.verifyNotEmpty(queryResultsOption)
            
            % Verify class of the Object
            testCase.verifyClass(queryResultsOption,'gcp.bigquery.BigQuery.QueryResultsOption');
            
            % Verify class of the Handle
            testCase.verifyClass(queryResultsOption.Handle,'com.google.cloud.bigquery.BigQuery$QueryResultsOption');
            
            % Receiving query results as object TableResult
            tableResult = job.getQueryResults(queryResultsOption);
            
            % Check if results are empty
            testCase.verifyNotEmpty(tableResult)
            
            % Verify class of the Object
            testCase.verifyClass(tableResult,'gcp.bigquery.TableResult');
            
            % Verify class of the Handle
            testCase.verifyClass(tableResult.Handle,'com.google.cloud.bigquery.TableResult');
            
            % Get results in a MATLAB table
            result_table = gbq2table(tableResult);
            
            % Verify if empty
            testCase.verifyNotEmpty(result_table);
            
            % Verify height of table
            testCase.verifyEqual(height(result_table),40);
            
            % Extract data from destination table to a Google Cloud storage
            % bucket
            
            % Setting gcs paths
            f = fileparts(pwd); parts = strsplit(string(f),filesep); parts_needed = parts(1:end-4);
            top_dir = strjoin(parts_needed,filesep);
            gcspath = strcat(top_dir, filesep, 'matlab-google-cloud-storage',filesep,'Software', filesep, 'MATLAB', filesep, 'startup.m');
            run(gcspath);
            
            % Create an example bucket and blob for receiving table data
            
            % Create gcs client
            gcstorage = gcp.storage.Storage();
            
            % Cloud Storage requires a unique bucket name globally
            uniquebucketname = [gcstorage.projectId 'testgbqbucketjson1' ];
            
            % Create bucketInfo and bucketTargetOptions since they are required for
            % bucket creation by Google Cloud Storage API
            bucketInfo = gcp.storage.BucketInfo.of(uniquebucketname);
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(gcstorage.projectId);
            
            % Creating bucket
            bucket = gcstorage.create(bucketInfo, bucketTargetOption);
            
            % Extract the results from Job to the Cloud Storage bucket
            % Here you can also replace bucket.bucketname with a string represneting an
            % existing bucket name that you might have
            % To query list of buckets that you might have in a project refer >> help gcp.storage.Storage.list
            bucketName = char(bucket.bucketName); % unique bucket name (can be different than the project Id)
            fileName = "tableresult.csv";
            
            % Extract results as a bulk from Cloud Storage to a local path
            gbqtable = gbq.getTable(datasetname,'newtable1');
            
            % Verify class of gbqtable
            testCase.verifyClass(gbqtable,'gcp.bigquery.Table')
            
            % Verify class of the Handle object
            testCase.verifyClass(gbqtable.Handle,'com.google.cloud.bigquery.Table');
            
            % Extract destination table results to a Google cloud storage
            % blob (in this case a csv file provided in variable filename
            % blob is always contained within a Google cloud Storage bucket
            % In this case bucket's name is int bucketName variable
            gbqtable.extract(fileName,bucketName);
            
            % create blobfield and bloboption to get access to the remote
            % blob using get() method on storage client
            blobfields = gcp.storage.Storage.BlobField;
            blobGetOption = gcp.storage.Storage.BlobGetOption.fields(blobfields);
            blob = gcstorage.get(bucketName,fileName,blobGetOption);
            
            % Using default temporary directory for downloading blob
            % content. In this case it will be the csv file
            downloadLocation = tempdir;
            
            % Download blob content to tempdir location
            blob.downloadTo(downloadLocation);
            
            % Verify if file exists on the specified path
            % 'downloadLocation'
            tf = isfile(char(strcat(downloadLocation,blob.name)));
            testCase.verifyTrue(tf);
            
            % Inject delay to avoid incomplete downloads
            pause(1)
            
            % Clearing local file after test completion
            delete(char(strcat(downloadLocation,blob.name)))
            
            %% List Jobs gbq.listJobs() JobListOption
            % create job listoption
            jobListOption1 = gcp.bigquery.BigQuery.JobListOption.pageSize(100);
            % verify class
            testCase.verifyClass(jobListOption1,'gcp.bigquery.BigQuery.JobListOption');
            % list jobs for this project
            jobList = gbq.listJobs(jobListOption1);
            
            %% Delete the blob after test
            
            write(testCase.logObj,'debug','Testing Blob Deletion method storage.delete\n');
            
            % Create BlobId
            blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name);
            
            % Delete Test Blob to empty Test Bucket
            tf = gcstorage.deleteObject(blobId);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
            
            %% Delete the bucket after test
            write(testCase.logObj,'debug','Testing Bucket Deletion method storage.deleteObject\n');
            
            % Create BucketSourceOption object to help bucket deletion
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(gcstorage.projectId);
            
            % Delete Test Bucket
            tf = gcstorage.deleteObject(bucket.bucketName, bucketSourceOption);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
            
            %% Delete Table
            
            % Delete the Table object
            tf = gbq.deleteTable(tableId);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
            
            % Verify if table still exists
            tf = gbqtable.exists();
            % Verify this is false
            testCase.verifyFalse(tf);
            %% Delete Dataset
            
            tf = gbq.deleteDataset(datasetname);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
        end
        
        %% Test @BigQuery methods listTables getTables and @Table methods delete and exists
        function testTable(testCase)
            % Create a client
            gbq = testCase.gbqclient;
            
            % Creating options with which Job should be created
            
            % Create Job Field
            jobField = gcp.bigquery.BigQuery.JobField.values;
            
            % Create Job Creating Option
            jobOptions = gcp.bigquery.BigQuery.JobOption.fields(jobField);
            
            % Creating Job Id
            randomJobId = gcp.bigquery.JobId.createJobId();
            
            % Create a JobId Object using the random jobid created above
            jobId = gcp.bigquery.JobId.of(gbq.ProjectId,randomJobId);
            
            % Setting properties such as QueryJobconfiguration and JobId for the object JobInfo
            query = "SELECT title, comment, contributor_ip, timestamp, num_characters FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0 LIMIT 40;";
            queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
            queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setUseLegacySql(true);
            queryJobConfigurationBuilder =  queryJobConfigurationBuilder.setAllowLargeResults(true);
            
            % Create a random dataset name
            datasetname = gcp.bigquery.JobId.createJobId();
            
            % Create a datasetId
            projectid = gbq.ProjectId;
            datasetId = gcp.bigquery.DatasetId.of(projectid,datasetname);
            
            % Create datasetInfo
            datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);
            
            % Create datasetfields for listing
            datasetField = gcp.bigquery.BigQuery.DatasetField.valuesOf;
            
            % Create datasetOptions with the fields
            datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField);
            
            % Create a new dataset
            dataSet = gbq.create(datasetInfo,datasetOption);
            
            % Set destination dataset and table
            tableId = gcp.bigquery.TableId.of(datasetname,'newtable1');
            queryJobConfigurationBuilder = queryJobConfigurationBuilder.setDestinationTable(tableId);
            queryJobConfiguration = queryJobConfigurationBuilder.build;
            
            % Create JobInfo for the destination table and dataset
            jobInfobuilder = gcp.bigquery.JobInfo.newBuilder(queryJobConfiguration);
            jobInfobuilder = jobInfobuilder.setJobId(jobId);
            jobInfo = jobInfobuilder.build;
            
            % Job creation
            job = gbq.create(jobInfo,jobOptions);
            
            % Polling for job completion
            job.waitFor
            
            % Setting options for the way you would want query results to be returned
            queryResultsOption = gcp.bigquery.BigQuery.QueryResultsOption.pageSize(100);
            
            % Receiving query results as object TableResult
            job.getQueryResults(queryResultsOption);
            
            % Testing listTables, TableId, Table,
            % Table.exists(),Table.delete()
            
            % List tables
            tableList = gbq.listTables(datasetname);
            tableidarr = tableList{:,2};
            
            % Check if created destination table exists
            
            % test if table created above exists in the list of
            % tableids
            tf = any(strcmp(tableidarr,'newtable1'));
            
            % Verify if true
            testCase.verifyTrue(tf);
            
            % Get Handle for table object
            gbqTable = gbq.getTable(datasetname,'newtable1');
            
            % Verify Class
            testCase.verifyClass(gbqTable,'gcp.bigquery.Table');
            
            % Verify Class Handle
            testCase.verifyClass(gbqTable.Handle,'com.google.cloud.bigquery.Table');
            
            % Create TableId
            tableId = gcp.bigquery.TableId.of(datasetname,'newtable1');
            
            % Verify TableId is not an empty object
            testCase.verifyNotEmpty(tableId);
            
            % Verify class
            testCase.verifyClass(tableId,'gcp.bigquery.TableId');
            
            % Verify Handle
            testCase.verifyClass(tableId.Handle,'com.google.cloud.bigquery.TableId');
            
            %% Delete Table
            
            % Delete the Table object
            tf = gbq.deleteTable(tableId);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
            
            % Verify if table still exists
            tf = gbqTable.exists();
            
            % Verify this is false
            testCase.verifyFalse(tf);
            %% Delete Dataset
            
            tf = gbq.deleteDataset(datasetname);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
            
        end
        
        %% Test @FormatOptions
        function testFormatOption(testCase)
            
            % Create a csv format options
            csvformatOptions = gcp.bigquery.FormatOptions.csv;
            
            % Verifying class of object
            testCase.verifyClass(csvformatOptions,'gcp.bigquery.FormatOptions');
            
            % Verifying class Handle
            testCase.verifyClass(csvformatOptions.Handle,'com.google.cloud.bigquery.CsvOptions');
            
            % Create an avro format options
            avroformatOptions = gcp.bigquery.FormatOptions.avro;
            
            % Verifying class of object
            testCase.verifyClass(avroformatOptions,'gcp.bigquery.FormatOptions');
            
            % Verifying class Handle
            testCase.verifyClass(avroformatOptions.Handle,'com.google.cloud.bigquery.FormatOptions');
            
            % Create a json format options
            jsonformatOptions = gcp.bigquery.FormatOptions.json;
            
            % Verifying class of object
            testCase.verifyClass(jsonformatOptions,'gcp.bigquery.FormatOptions');
            
            % Verifying class Handle
            testCase.verifyClass(jsonformatOptions.Handle,'com.google.cloud.bigquery.FormatOptions');
            
            % Create a orc format options
            orcformatOptions = gcp.bigquery.FormatOptions.orc;
            
            % Verifying class of object
            testCase.verifyClass(orcformatOptions,'gcp.bigquery.FormatOptions');
            
            % Verifying class Handle
            testCase.verifyClass(orcformatOptions.Handle,'com.google.cloud.bigquery.FormatOptions');
            
            % Create a parquet format options
            parquetformatOptions = gcp.bigquery.FormatOptions.parquet;
            
            % Verifying class of object
            testCase.verifyClass(parquetformatOptions,'gcp.bigquery.FormatOptions');
            
            % Verifying class Handle
            testCase.verifyClass(parquetformatOptions.Handle,'com.google.cloud.bigquery.FormatOptions');
        end
        
        %% Test +JobInfo/@CreateDisposition and +JobInfo/@WriteDisposition
        function testCreateandWriteDisposition(testCase)
            
            %% Enum Constant and Description for @CreateDisposition
            % ---------------------------------------------------
            % * CREATE_IF_NEEDED : Configures the job to create the table if it does not exist.
            %
            % * CREATE_NEVER : Configures the job to fail with a not-found error if the table does not exist.
            
            createDispositionEnum = 'CREATE_IF_NEEDED';
            createDispositionConfig = gcp.bigquery.JobInfo.CreateDisposition.valueOf(createDispositionEnum);
            
            % Verifying class of object
            testCase.verifyClass(createDispositionConfig,'gcp.bigquery.JobInfo.CreateDisposition');
            
            % Verifying class Handle
            testCase.verifyClass(createDispositionConfig.Handle,'com.google.cloud.bigquery.JobInfo$CreateDisposition');
            
            createDispositionEnum = 'CREATE_NEVER';
            createDispositionConfig = gcp.bigquery.JobInfo.CreateDisposition.valueOf(createDispositionEnum);
            
            % Verifying class of object
            testCase.verifyClass(createDispositionConfig,'gcp.bigquery.JobInfo.CreateDisposition');
            
            % Verifying class Handle
            testCase.verifyClass(createDispositionConfig.Handle,'com.google.cloud.bigquery.JobInfo$CreateDisposition');
            
            %% Enum Constant and Description for WriteDisposition
            % --------------------------------------------------
            % * WRITE_APPEND : Configures the job to append data to the table if it already exists.
            %
            % * WRITE_EMPTY : Configures the job to fail with a duplicate error if the table already exists.
            %
            % * WRITE_TRUNCATE : Configures the job to overwrite the table data if table already exists.
            
            writeDispositionEnum = 'WRITE_APPEND';
            writeDispositionConfig = gcp.bigquery.JobInfo.WriteDisposition.valueOf(writeDispositionEnum);
            
            % Verifying class of object
            testCase.verifyClass(writeDispositionConfig,'gcp.bigquery.JobInfo.WriteDisposition');
            
            % Verifying class Handle
            testCase.verifyClass(writeDispositionConfig.Handle,'com.google.cloud.bigquery.JobInfo$WriteDisposition');
            
            writeDispositionEnum = 'WRITE_EMPTY';
            writeDispositionConfig = gcp.bigquery.JobInfo.WriteDisposition.valueOf(writeDispositionEnum);
            
            % Verifying class of object
            testCase.verifyClass(writeDispositionConfig,'gcp.bigquery.JobInfo.WriteDisposition');
            
            % Verifying class Handle
            testCase.verifyClass(writeDispositionConfig.Handle,'com.google.cloud.bigquery.JobInfo$WriteDisposition');
            
            writeDispositionEnum = 'WRITE_TRUNCATE';
            writeDispositionConfig = gcp.bigquery.JobInfo.WriteDisposition.valueOf(writeDispositionEnum);
            
            % Verifying class of object
            testCase.verifyClass(writeDispositionConfig,'gcp.bigquery.JobInfo.WriteDisposition');
            
            % Verifying class Handle
            testCase.verifyClass(writeDispositionConfig.Handle,'com.google.cloud.bigquery.JobInfo$WriteDisposition');
        end
        
        %% Test @LoadJobConfiguration and +LoadJobConfiguration/@Builder
        function testLoadJobConfiguration(testCase)
            %% Test methods from @LoadJobConfiguration
            %  LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.builder(tableId,sourceUri);
            %  LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.newBuilder(tableId,sourceUri);
            %  LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.newBuilder(tableId,sourceUri,formatOptions);
            %  LoadJobConfiguration = gcp.bigquery.LoadJobConfiguration.of(tableId,sourceUri);
            %  LoadJobConfiguration = gcp.bigquery.LoadJobConfiguration.of(tableId,sourceUri,formatOptions);
            
            % Requirements:
            % * tableId
            % * sourceUri
            % * formatOptions
            
            %% Creating dataset and TableId
            % Create a client
            gbq = testCase.gbqclient;
            
            % Access Project id for the service account
            projectid = gbq.ProjectId;
            
            % Create a random dataset name
            datasetname = gcp.bigquery.JobId.createJobId();
            
            % Create a datasetId
            datasetId = gcp.bigquery.DatasetId.of(projectid,datasetname);
            
            % Create datasetInfo
            datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);
            % Create datasetfields for listing
            datasetField = gcp.bigquery.BigQuery.DatasetField.valuesOf;
            % Create datasetOptions with the fields
            datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField);
            % Create a new dataset
            dataSet = gbq.create(datasetInfo,datasetOption);
            
            % TableId for destination tables
            csvtableId = gcp.bigquery.TableId.of(datasetname,'csvnewtable');
            parquettableId = gcp.bigquery.TableId.of(datasetname,'parquetnewtable');
            jsontableId = gcp.bigquery.TableId.of(datasetname,'jsonnewtable');
            %avrotableId = gcp.bigquery.TableId.of(datasetname,'avronewtable');
            %orctableId = gcp.bigquery.TableId.of(datasetname,'orcnewtable');
            
            %% Creating sourceuri for different GCS blobs
            % Setting gcs paths
            f = fileparts(pwd); parts = strsplit(string(f),filesep); parts_needed = parts(1:end-4);
            top_dir = strjoin(parts_needed,filesep);
            gcspath = strcat(top_dir, filesep, 'matlab-google-cloud-storage',filesep,'Software', filesep, 'MATLAB', filesep, 'startup.m');
            run(gcspath);
            
            % Create an example bucket and blob for receiving table data
            
            % Create gcs client
            gcstorage = gcp.storage.Storage();
            
            % Cloud Storage requires a unique bucket name globally
            uniquebucketname = [gcstorage.projectId 'testgbqbucketjson1' ];
            
            % Create bucketInfo and bucketTargetOptions since they are required for
            % bucket creation by Google Cloud Storage API
            bucketInfo = gcp.storage.BucketInfo.of(uniquebucketname);
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(gcstorage.projectId);
            
            % Creating bucket
            bucket = gcstorage.create(bucketInfo, bucketTargetOption);
            
            % Create blob
            csvblob = bucket.create("airlinesmall.csv","airlinesmall.csv");
            parquetblob = bucket.create("outages.parquet","outages.parquet");
            jsonblob = bucket.create("states.json","states.json");
            
            csvsourceUri = strcat("gs://", uniquebucketname, '/', csvblob.name);
            parquetsourceUri = strcat("gs://", uniquebucketname, '/', parquetblob.name);
            jsonsourceUri =  strcat("gs://", uniquebucketname, '/', jsonblob.name);
            
            %% formatOptions
            csvformatOptions = gcp.bigquery.FormatOptions.csv;
            parquetformatOptions = gcp.bigquery.FormatOptions.parquet;
            jsonformatOptions = gcp.bigquery.FormatOptions.json;
            
            %% Testing methods for @Loadconfiguration now
            
            fprintf("\nTesting methods for @Loadconfiguration now\n");
            LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.builder(csvtableId,csvsourceUri);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.builder(parquettableId,parquetsourceUri);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.builder(jsontableId,jsonsourceUri);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.newBuilder(csvtableId,csvsourceUri);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.newBuilder(parquettableId,parquetsourceUri);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.newBuilder(jsontableId,jsonsourceUri);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.newBuilder(csvtableId,csvsourceUri,csvformatOptions);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.newBuilder(parquettableId,parquetsourceUri,parquetformatOptions);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            LoadJobConfigurationBuilder = gcp.bigquery.LoadJobConfiguration.newBuilder(jsontableId,jsonsourceUri,jsonformatOptions);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            LoadJobConfiguration = gcp.bigquery.LoadJobConfiguration.of(csvtableId,csvsourceUri);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfiguration,'gcp.bigquery.LoadJobConfiguration');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfiguration.Handle,'com.google.cloud.bigquery.LoadJobConfiguration');
            
            LoadJobConfiguration = gcp.bigquery.LoadJobConfiguration.of(parquettableId,parquetsourceUri);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfiguration,'gcp.bigquery.LoadJobConfiguration');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfiguration.Handle,'com.google.cloud.bigquery.LoadJobConfiguration');
            
            LoadJobConfiguration= gcp.bigquery.LoadJobConfiguration.of(jsontableId,jsonsourceUri);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfiguration,'gcp.bigquery.LoadJobConfiguration');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfiguration.Handle,'com.google.cloud.bigquery.LoadJobConfiguration');
            
            LoadJobConfiguration = gcp.bigquery.LoadJobConfiguration.of(csvtableId,csvsourceUri,csvformatOptions);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfiguration,'gcp.bigquery.LoadJobConfiguration');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfiguration.Handle,'com.google.cloud.bigquery.LoadJobConfiguration');
            
            LoadJobConfiguration = gcp.bigquery.LoadJobConfiguration.of(parquettableId,parquetsourceUri,parquetformatOptions);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfiguration,'gcp.bigquery.LoadJobConfiguration');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfiguration.Handle,'com.google.cloud.bigquery.LoadJobConfiguration');
            LoadJobConfiguration = gcp.bigquery.LoadJobConfiguration.of(jsontableId,jsonsourceUri,jsonformatOptions);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfiguration,'gcp.bigquery.LoadJobConfiguration');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfiguration.Handle,'com.google.cloud.bigquery.LoadJobConfiguration');
            
            fprintf("\nTesting methods for @Loadconfiguration complete\n");
            
            %% Testing methods from +LoadJobConfiguration/@Builder
            fprintf("\nTesting methods for @Loadconfiguration.Builder now\n");
            
            %% test setAutodetect()
            LoadJobConfigurationBuilder = LoadJobConfigurationBuilder.setAutodetect(java.lang.Boolean(0));
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            LoadJobConfigurationBuilder = LoadJobConfigurationBuilder.setAutodetect(java.lang.Boolean(1));
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            %% test setdestinationTableId()
            LoadJobConfigurationBuilder = LoadJobConfigurationBuilder.setDestinationTable(csvtableId);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            %% test setformatoptions()
            LoadJobConfigurationBuilder = LoadJobConfigurationBuilder.setFormatOptions(csvformatOptions);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            %% test createdisposition()
            createDispositionEnum = 'CREATE_IF_NEEDED';
            createDispositionConfig = gcp.bigquery.JobInfo.CreateDisposition.valueOf(createDispositionEnum);
            LoadJobConfigurationBuilder = LoadJobConfigurationBuilder.setCreateDisposition(createDispositionConfig);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            %% test setwritedisposition()
            writeDispositionEnum = 'WRITE_APPEND';
            writeDispositionConfig = gcp.bigquery.JobInfo.WriteDisposition.valueOf(writeDispositionEnum);
            LoadJobConfigurationBuilder = LoadJobConfigurationBuilder.setWriteDisposition(writeDispositionConfig);
            
            % Verify object class
            testCase.verifyClass(LoadJobConfigurationBuilder,'gcp.bigquery.LoadJobConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfigurationBuilder.Handle,'com.google.cloud.bigquery.LoadJobConfiguration$Builder');
            
            %% test build()
            LoadJobConfiguration = LoadJobConfigurationBuilder.build;
            
            % Verify object class
            testCase.verifyClass(LoadJobConfiguration,'gcp.bigquery.LoadJobConfiguration');
            
            % Verify Handle class
            testCase.verifyClass(LoadJobConfiguration.Handle,'com.google.cloud.bigquery.LoadJobConfiguration');
            
            fprintf("\nTesting methods for @Loadconfiguration.Builder complete\n");
            
            %% Clean up resources
            % * GCS Blob files
            % * GCS Bucket
            % * GBQ Dataset
            
            % Cleaning up blobs
            blobSourceOption = gcp.storage.Blob.BlobSourceOption.generationMatch;
            
            tf = csvblob.delete(blobSourceOption);
            testCase.verifyTrue(tf);
            
            tf = parquetblob.delete(blobSourceOption);
            testCase.verifyTrue(tf);
            
            tf = jsonblob.delete(blobSourceOption);
            testCase.verifyTrue(tf);
            
            fprintf("\nAll blobs deleted\n");
            
            % Cleaning up bucket
            bucketSourceOption = gcp.storage.Bucket.BucketSourceOption.metagenerationMatch;
            
            tf = bucket.delete(bucketSourceOption);
            testCase.verifyTrue(tf);
            
            fprintf("\nBucket deleted\n");
            
            % Delete dataset
            tf = gbq.deleteDataset(datasetname);
            testCase.verifyTrue(tf);
            fprintf("\nDataset deleted\n");
            
            fprintf("Completed testing LoadJobconfiguration and its builder methods ");
            
        end
        
        %% Test @WriteChannelConfiguration and +WriteChannelConfiguration/@Builder
        function testWriteChannelConfiguration(testCase)
            
            % Supported methods within @WriteChannelConfiguration
            %
            % writeChannelConfigurationBuilder	= WriteChannelConfiguration.gcp.bigquery.WriteChannelConfiguration.newBuilder(TableId)
            % writeChannelConfigurationBuilder	WriteChannelConfiguration.newBuilder(TableId,FormatOptions)
            % writeChannelConfiguration	= WriteChannelConfiguration.of(TableId)
            % writeChannelConfiguration	= WriteChannelConfiguration.of(TableId ,FormatOptions)
            %
            % Testing requirements
            % * test dataset
            % * test tableId
            % * formatoptions
            
            %% Creating dataset and TableId
            % Create a client
            gbq = testCase.gbqclient;
            
            % Access Project id for the service account
            projectid = gbq.ProjectId;
            
            % Create a random dataset name
            datasetname = gcp.bigquery.JobId.createJobId();
            
            % Create a datasetId
            datasetId = gcp.bigquery.DatasetId.of(projectid,datasetname);
            
            % Create datasetInfo
            datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);
            % Create datasetfields for listing
            datasetField = gcp.bigquery.BigQuery.DatasetField.valuesOf;
            % Create datasetOptions with the fields
            datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField);
            % Create a new dataset
            dataSet = gbq.create(datasetInfo,datasetOption);
            
            % TableId for destination tables
            tableId = gcp.bigquery.TableId.of(datasetname,'csvnewtable');
            
            %% formatOptions
            formatOptions = gcp.bigquery.FormatOptions.csv;
            
            %% Testing methods for @WriteChannelConfiguration now
            writeChannelConfigurationBuilder = gcp.bigquery.WriteChannelConfiguration.newBuilder(tableId);
            
            % Verify object class
            testCase.verifyClass(writeChannelConfigurationBuilder,'gcp.bigquery.WriteChannelConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(writeChannelConfigurationBuilder.Handle,'com.google.cloud.bigquery.WriteChannelConfiguration$Builder');
            
            writeChannelConfigurationBuilder =  gcp.bigquery.WriteChannelConfiguration.newBuilder(tableId,formatOptions);
            
            % Verify object class
            testCase.verifyClass(writeChannelConfigurationBuilder,'gcp.bigquery.WriteChannelConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(writeChannelConfigurationBuilder.Handle,'com.google.cloud.bigquery.WriteChannelConfiguration$Builder');
            
            writeChannelConfiguration= gcp.bigquery.WriteChannelConfiguration.of(tableId);
            
            % Verify object class
            testCase.verifyClass(writeChannelConfiguration,'gcp.bigquery.WriteChannelConfiguration');
            
            % Verify Handle class
            testCase.verifyClass(writeChannelConfiguration.Handle,'com.google.cloud.bigquery.WriteChannelConfiguration');
            
            writeChannelConfiguration = gcp.bigquery.WriteChannelConfiguration.of(tableId ,formatOptions);
            % Verify object class
            testCase.verifyClass(writeChannelConfiguration,'gcp.bigquery.WriteChannelConfiguration');
            
            % Verify Handle class
            testCase.verifyClass(writeChannelConfiguration.Handle,'com.google.cloud.bigquery.WriteChannelConfiguration');
            
            fprintf("\nTesting methods for @WriteChannelConfiguration complete\n");
            
            %% Testing methods from +LoadJobConfiguration/@Builder
            fprintf("\nTesting methods for WriteChannelConfiguration.Builder now\n");
            
            %% testing AutoDetect
            writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setAutodetect(java.lang.Boolean(0));
            % Verify object class
            testCase.verifyClass(writeChannelConfigurationBuilder,'gcp.bigquery.WriteChannelConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(writeChannelConfigurationBuilder.Handle,'com.google.cloud.bigquery.WriteChannelConfiguration$Builder');
            
            writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setAutodetect(java.lang.Boolean(1));
            
            % Verify object class
            testCase.verifyClass(writeChannelConfigurationBuilder,'gcp.bigquery.WriteChannelConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(writeChannelConfigurationBuilder.Handle,'com.google.cloud.bigquery.WriteChannelConfiguration$Builder');
            
            %% testing setDestinationTable
            writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setDestinationTable(tableId);
            
            % Verify object class
            testCase.verifyClass(writeChannelConfigurationBuilder,'gcp.bigquery.WriteChannelConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(writeChannelConfigurationBuilder.Handle,'com.google.cloud.bigquery.WriteChannelConfiguration$Builder');
            
            %% testing setFormatOptions
            writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setFormatOptions(formatOptions);
            
            % Verify object class
            testCase.verifyClass(writeChannelConfigurationBuilder,'gcp.bigquery.WriteChannelConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(writeChannelConfigurationBuilder.Handle,'com.google.cloud.bigquery.WriteChannelConfiguration$Builder');
            
            %% testing setWriteDisposition
            writeDispositionEnum = 'WRITE_APPEND';
            writeDispositionConfig = gcp.bigquery.JobInfo.WriteDisposition.valueOf(writeDispositionEnum);
            writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setWriteDisposition(writeDispositionConfig);
            
            % Verify object class
            testCase.verifyClass(writeChannelConfigurationBuilder,'gcp.bigquery.WriteChannelConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(writeChannelConfigurationBuilder.Handle,'com.google.cloud.bigquery.WriteChannelConfiguration$Builder');
            
            %% testing setCreateDisposition
            createDispositionEnum = 'CREATE_IF_NEEDED';
            createDispositionConfig = gcp.bigquery.JobInfo.CreateDisposition.valueOf(createDispositionEnum);
            writeChannelConfigurationBuilder = writeChannelConfigurationBuilder.setCreateDisposition(createDispositionConfig);
            
            % Verify object class
            testCase.verifyClass(writeChannelConfigurationBuilder,'gcp.bigquery.WriteChannelConfiguration.Builder');
            
            % Verify Handle class
            testCase.verifyClass(writeChannelConfigurationBuilder.Handle,'com.google.cloud.bigquery.WriteChannelConfiguration$Builder');
            
            %% testing build()
            writeChannelConfiguration = writeChannelConfigurationBuilder.build;
            
            % Verify object class
            testCase.verifyClass(writeChannelConfiguration,'gcp.bigquery.WriteChannelConfiguration');
            
            % Verify Handle class
            testCase.verifyClass(writeChannelConfiguration.Handle,'com.google.cloud.bigquery.WriteChannelConfiguration');
            
            %% Cleaning Resources
            % * GBQ dataset
            
            % Delete dataset
            tf = gbq.deleteDataset(datasetname);
            testCase.verifyTrue(tf);
            fprintf("\nDataset deleted\n");
            fprintf("\nTesting methods for @WriteChannelConfiguration.Builder complete\n");
        end
        
        %% Test function copyfiletobigquery
        function testCopyFileToBigquery(testCase)
            
            % Testing function for Loading data into BigQuery Table with local file
            
            %% Creating dataset and TableId
            % Create a client
            gbq = testCase.gbqclient;
            
            % Access Project id for the service account
            projectid = gbq.ProjectId;
            
            % Create a random dataset name
            datasetname = gcp.bigquery.JobId.createJobId();
            
            % Create a datasetId
            datasetId = gcp.bigquery.DatasetId.of(projectid,datasetname);
            
            % Create datasetInfo
            datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);
            % Create datasetfields for listing
            datasetField = gcp.bigquery.BigQuery.DatasetField.valuesOf;
            % Create datasetOptions with the fields
            datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField);
            % Create a new dataset
            dataSet = gbq.create(datasetInfo,datasetOption);
            
            % TableId for destination tables
            csvtableId = gcp.bigquery.TableId.of(datasetname,'csvnewtable');
            parquettableId = gcp.bigquery.TableId.of(datasetname,'parquetnewtable');
            jsontableId = gcp.bigquery.TableId.of(datasetname,'jsonnewtable');
            %avrotableId = gcp.bigquery.TableId.of(datasetname,'avronewtable');
            %orctableId = gcp.bigquery.TableId.of(datasetname,'orcnewtable');
            
            % creating table first time
            filename  = 'airlinesmall_1.csv';
            createdisposition = 'CREATE_NEVER';
            writedisposition = 'WRITE_TRUNCATE';
            % Should fail since table does not exist and create disposition
            % is set to CREATE_NEVER
            try
                copyfiletobigquery(gbq,datasetname,char(csvtableId.Handle.getTable),filename,createdisposition,writedisposition);
            catch
                fprintf("\ncorrectly errored out when disposition was 'CREATE_NEVER'\n");
            end
            
            % Switching disposition to create a table if needed
            createdisposition = 'CREATE_IF_NEEDED';
            copyfiletobigquery(gbq,datasetname,char(csvtableId.Handle.getTable),filename,createdisposition,writedisposition);
            
            fprintf("\ncopied csv file to gbq table successfully\n");
            fprintf("\nCreate disposition was 'CREATE_IF_NEEDED'\n");
            
            % Should give us an error since write_disposition is WRITE_EMPTY
            filename = 'airlinesmall_2.csv';
            writedisposition = 'WRITE_EMPTY';
            try
                copyfiletobigquery(gbq,datasetname,char(csvtableId.Handle.getTable),filename,createdisposition,writedisposition);
            catch
                fprintf("\ncorrectly errored out when disposition was 'WRITE_EMPTY'\n");
            end
            
            % Should successfully append to existing table when disposition is 'WRITE_APPEND'
            writedisposition = 'WRITE_APPEND';
            copyfiletobigquery(gbq,datasetname,char(csvtableId.Handle.getTable),filename,createdisposition,writedisposition);
            
            fprintf("\ncorrectly appended when disposition was 'WRITE_APPEND'\n");
            
            % Test for parquet copy
            filename = 'outages.parquet';
            copyfiletobigquery(gbq,datasetname,char(parquettableId.Handle.getTable),filename,createdisposition,writedisposition);
            
            fprintf("\ncopied parquet file to gbq table successfully\n");
            
            % Test for json copy
            filename = 'states.json';
            copyfiletobigquery(gbq,datasetname,char(jsontableId.Handle.getTable),filename,createdisposition,writedisposition);
            
            fprintf("\ncopied newline json file to gbq table successfully\n");
            
            %% Cleaning up resources
            % Cleaning GBQ tables
            % Cleaning dataset
            
            % Get handles to  tables
            
            tf = gbq.deleteTable(csvtableId);
            testCase.verifyTrue(tf);
            
            tf = gbq.deleteTable(parquettableId);
            testCase.verifyTrue(tf);
            
            tf = gbq.deleteTable(jsontableId);
            testCase.verifyTrue(tf);
            
            fprintf(strcat("\nAll GBQ tables deleted from dataset",datasetname,"\n"));
            
            % Delete dataset
            tf = gbq.deleteDataset(datasetname);
            testCase.verifyTrue(tf);
            fprintf("\nDataset deleted\n");
            
            fprintf("\nCompleted testing copyfiletogbqtable\n");
        end
        
        %% Test function GCStoGBQtable
        function testLoadGCStoBigQuery(testCase)
            % Testing function for Loading data into BigQuery Table with local file
            
            %% Creating dataset and TableId
            % Create a client
            gbq = testCase.gbqclient;
            
            % Access Project id for the service account
            projectid = gbq.ProjectId;
            
            % Create a random dataset name
            datasetname = gcp.bigquery.JobId.createJobId();
            
            % Create a datasetId
            datasetId = gcp.bigquery.DatasetId.of(projectid,datasetname);
            
            % Create datasetInfo
            datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);
            % Create datasetfields for listing
            datasetField = gcp.bigquery.BigQuery.DatasetField.valuesOf;
            % Create datasetOptions with the fields
            datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField);
            % Create a new dataset
            dataSet = gbq.create(datasetInfo,datasetOption);
            
            % TableId for destination tables
            csvtableId = gcp.bigquery.TableId.of(datasetname,'csvnewtable');
            parquettableId = gcp.bigquery.TableId.of(datasetname,'parquetnewtable');
            jsontableId = gcp.bigquery.TableId.of(datasetname,'jsonnewtable');
            %avrotableId = gcp.bigquery.TableId.of(datasetname,'avronewtable');
            %orctableId = gcp.bigquery.TableId.of(datasetname,'orcnewtable');
            
            % Setting gcs paths
            f = fileparts(pwd); parts = strsplit(string(f),filesep); parts_needed = parts(1:end-4);
            top_dir = strjoin(parts_needed,filesep);
            gcspath = strcat(top_dir, filesep, 'matlab-google-cloud-storage',filesep,'Software', filesep, 'MATLAB', filesep, 'startup.m');
            run(gcspath);
            
            % Create an example bucket and blob for loading gbq table for
            % testing
            
            % Create gcs client
            gcstorage = gcp.storage.Storage();
            
            % Cloud Storage requires a unique bucket name globally
            uniquebucketname = [gcstorage.projectId 'testgbqbucketjson1' ];
            
            % Create bucketInfo and bucketTargetOptions since they are required for
            % bucket creation by Google Cloud Storage API
            bucketInfo = gcp.storage.BucketInfo.of(uniquebucketname);
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(gcstorage.projectId);
            
            % Creating bucket
            bucket = gcstorage.create(bucketInfo, bucketTargetOption);
            
            % Create blob
            csvblob = bucket.create("airlinesmall.csv","airlinesmall.csv");
            parquetblob = bucket.create("outages.parquet","outages.parquet");
            jsonblob = bucket.create("states.json","states.json");
            
            % Create source uri not required
            csvsourceUri = strcat("gs://", uniquebucketname, '/', csvblob.name);
            parquetsourceUri = strcat("gs://", uniquebucketname, '/', parquetblob.name);
            jsonsourceUri =  strcat("gs://", uniquebucketname, '/', jsonblob.name);
            
            createdisposition = 'CREATE_IF_NEEDED';
            writedisposition = 'WRITE_APPEND';
            
            % writing csv blob
            gcstogbqtable(gbq,datasetname,char(csvtableId.Handle.getTable),bucket.bucketName,csvblob.name,createdisposition,writedisposition);
            
            fprintf(strcat("\n\nSuccessfully loaded ","table '", string(csvtableId.Handle.getTable),"' with ", csvsourceUri,"\n"));
            
            % writing parquet blob
            gcstogbqtable(gbq,datasetname,char(parquettableId.Handle.getTable),bucket.bucketName,parquetblob.name,createdisposition,writedisposition);
            
            fprintf(strcat("\n\nSuccessfully loaded ","table '", string(parquettableId.Handle.getTable),"' with ", parquetsourceUri));
            
            % writing json blob
            gcstogbqtable(gbq,datasetname,char(jsontableId.Handle.getTable),bucket.bucketName,jsonblob.name,createdisposition,writedisposition);
            
            fprintf(strcat("\n\nSuccessfully loaded ","table '", string(jsontableId.Handle.getTable),"' with ", jsonsourceUri));
            
            %% Clean up resources
            % * GCS Blob files
            % * GCS Bucket
            % * GBQ Tables
            % * GBQ Dataset
            
            % Cleaning up blobs
            blobSourceOption = gcp.storage.Blob.BlobSourceOption.generationMatch;
            
            tf = csvblob.delete(blobSourceOption);
            testCase.verifyTrue(tf);
            
            tf = parquetblob.delete(blobSourceOption);
            testCase.verifyTrue(tf);
            
            tf = jsonblob.delete(blobSourceOption);
            testCase.verifyTrue(tf);
            
            fprintf("\n\nAll blobs deleted");
            
            % Cleaning up bucket
            bucketSourceOption = gcp.storage.Bucket.BucketSourceOption.metagenerationMatch;
            
            tf = bucket.delete(bucketSourceOption);
            testCase.verifyTrue(tf);
            
            fprintf("\n\nBucket deleted");
            
            % Get handles to  tables and delete
            tf = gbq.deleteTable(csvtableId);
            testCase.verifyTrue(tf);
            
            tf = gbq.deleteTable(parquettableId);
            testCase.verifyTrue(tf);
            
            tf = gbq.deleteTable(jsontableId);
            testCase.verifyTrue(tf);
            
            fprintf(strcat("\n\nAll GBQ tables deleted from dataset ",datasetname));
            
            % Delete dataset
            tf = gbq.deleteDataset(datasetname);
            testCase.verifyTrue(tf);
            fprintf("\n\nDataset deleted");
            
            fprintf("\nCompleted testing gcstogbqtable function ");
        end
        
        
        %% Test @StandardTableDefinition and +StandardTableDefinition /@Builder, bigquery.create(), TableField.valueOf()
        function teststandardTableDefinition(testCase)
            % Create a client
            gbq = testCase.gbqclient;
            
            % Create StandardTableDefinition Builder
            StandardTableDefinitionBuilder = gcp.bigquery.StandardTableDefinition.newBuilder();
            
            % Create StandardTableDefinition
            StandardTableDefinition = StandardTableDefinitionBuilder.build();
            
            % Access Project id for the service account
            projectid = gbq.ProjectId;
            
            % Create a random dataset name
            datasetname = gcp.bigquery.JobId.createJobId();
            
            % Create a datasetId
            datasetId = gcp.bigquery.DatasetId.of(projectid,datasetname);
            
            % Create datasetInfo
            datasetInfo = gcp.bigquery.DatasetInfo.of(datasetId);
            % Create datasetfields
            datasetField = gcp.bigquery.BigQuery.DatasetField.valuesOf;
            % Create datasetOptions with the fields
            datasetOption = gcp.bigquery.BigQuery.DatasetOption.fields(datasetField);
            % Create a new dataset
            dataSet = gbq.create(datasetInfo,datasetOption); %#ok<*NASGU>
            
            % Create TableId for a table and a given dataset
            tableId = gcp.bigquery.TableId.of(datasetname,"new_gbq_tablename");
            
            % Create TableInfo:
            tableInfo = gcp.bigquery.TableInfo.of(tableId,StandardTableDefinition);
            
            % Create TableField and TableOption
            tableFields = gcp.bigquery.BigQuery.TableField.valueOf('ID','LOCATION');
            tableOption = gcp.bigquery.BigQuery.TableOption.fields(tableFields);
            
            % Create a new and empty table
            emptytable = gbq.create(tableInfo,tableOption);
            % Verify Class
            testCase.verifyClass(emptytable,'gcp.bigquery.Table');
            
            % Clean up Table and Dataset
            % Delete Table
            tf = gbq.deleteTable(tableId);
            % Verify table deleted
            testCase.verifyTrue(tf);
            fprintf(strcat("\n\nAll GBQ tables deleted from dataset ",datasetname));
            
            % Delete dataset
            tf = gbq.deleteDataset(datasetname);
            % Verify dataset deleted
            testCase.verifyTrue(tf);
            fprintf("\n\nDataset deleted");
            
            fprintf("\nCompleted testing StandardTableDefinition and empty table creation using bigquery.create() for table ");
        end
        
        
        
        
    end
    
end

