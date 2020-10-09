## Getting Started

Once this package is installed and credentials for authentication have been setup, one can begin working with Google BigQuery™ interface. The [Basic Usage](BasicUsage.md) document provides greater details on the functions within this package.

The following is a simple example of how one can create a Google BigQuery™ client in order to query datasets using MATLAB. This example assumes you have a Google Cloud Service account and have followed the steps in [Installation](Installation.md) and [Authentication](Authentication.md).

### Creating a BigQuery Client
```
gbq_client = gcp.bigquery.BigQuery('pfREDACTED05.json')

gbq_client =
  BigQuery with properties:

    ProjectId: 'pfREDACTEDoy'
       Handle: [1x1 com.google.cloud.bigquery.BigQueryImpl]

```

### Constructing a BigQuery query
```
% query
smallquery = 'SELECT TOP( title, 10) as title, COUNT(*) as revision_count FROM [publicdata:samples.wikipedia] WHERE wp_namespace = 0;';

% configuration for query job
queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(smallquery);
queryJobConfigurationBuilder = queryJobConfigurationBuilder.setUseLegacySql(logical(1));
queryJobConfiguration = queryJobConfigurationBuilder.build

queryJobConfiguration =
  QueryJobConfiguration with properties:

    Handle: [1x1 com.google.cloud.bigquery.QueryJobConfiguration]

```

### Executing a query
```
% Gather results of query in a table
tableResult = gbq_client.query(queryJobConfiguration)

tableResult =
  TableResult with properties:

    Handle: [1x1 com.google.cloud.bigquery.TableResult]

% converting results to a MATLAB table
data_matlab_table = gbq2table(tableResult)

mattable =
                          title                          revision_count
    _________________________________________________    ______________

    "George W. Bush"                                         43652     
    "List of World Wrestling Entertainment employees"        30572     
    "Wikipedia"                                              29726     
    "United States"                                          27432     
    "Michael Jackson"                                        23245     
    "Jesus"                                                  21768     
    "Deaths in 2009"                                         20814     
    "World War II"                                           20546     
    "Britney Spears"                                         20529     
    "Wii"                                                    20225     

```

For more detailed and advanced functionalities such as making asynchronous queries and creating datasets, please refer to [BasicUsage](BasicUsage.md)

### Logging
When getting started, debugging can be helpful to get more feedback. Once the client has been created one can set the logging level to verbose as follows:
```
logObj = Logger.getLogger();
logObj.DisplayLevel = 'verbose';
```
See: [Logging](Logging.md) for more details.


[//]: #  (Copyright 2020 The MathWorks, Inc.)
