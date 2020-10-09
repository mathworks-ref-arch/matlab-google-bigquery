## Accessing Public datasets

### BigQuery™ Public Dataset
A [BigQuery public dataset](https://cloud.google.com/bigquery/public-dataBigQuery) is any dataset that is stored in BigQuery and made available to the general public through the Google Cloud Public Dataset Program. Public datasets are available for you to analyze using either legacy SQL or standard SQL queries.

You can share any of your datasets with the public by changing the dataset's access controls to allow access by `All Authenticated Users`. For more information about setting dataset access controls, see [Controlling access to datasets](https://cloud.google.com/bigquery/docs/dataset-access-controls).


### Kaggle Datasets
[Kaggle](http://www.kaggle.com/) is the world's largest data science community with powerful tools and resources to help you achieve your data science goals. Kaggle supports a variety of dataset publication formats encouraging dataset publishers to share their data on Kaggle in  an accessible, non-proprietary format further enabling data scientists to work with public datasets regardless of their tools. Variety of dataset publication formats commonly include CSV, JSON, SQLite, `BigQuery™ Public Dataset`

#### Search for BigQuery datasets on Kaggle

Access Kaggle Datasets [here](https://www.kaggle.com/datasets) and apply [`BigQuery filter`](https://www.kaggle.com/datasets?fileType=bigQuery).


#### Querying Public Datasets from MATLAB

` Create a Big query Client`
```
gbqclient = gcp.bigquery.BigQuery('credentials.json');

gbqclient =

  BigQuery with properties:

    ProjectId: 'prxxxxxxxoy'
       Handle: [1x1 com.google.cloud.bigquery.BigQueryImpl]

```

`Write a query to a sample public dataset`
```
smallquery = 'SELECT * FROM `bigquery-public-data.catalonian_mobile_coverage.mobile_data_2015_2017` LIMIT 5;';
```

`Build configuration for Query`

```
queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(smallquery);
queryJobConfigurationBuilder = queryJobConfigurationBuilder.setUseLegacySql(false);
queryJobConfiguration = queryJobConfigurationBuilder.build;

queryJobConfiguration =

  QueryJobConfiguration with properties:

    Handle: [1x1 com.google.cloud.bigquery.QueryJobConfiguration]

```

`Query and Return Results`

```
tableResult = gbqclient.query(queryJobConfiguration);

tableResult =

  TableResult with properties:

    Handle: [1x1 com.google.cloud.bigquery.TableResult]


% Extracting query results into a MATLAB table
mattable = gbq2table(tableResult1);

mattable =

  5x19 table

            date              hour       lat       long     signal     network     operator     status       description         net      speed    satellites    precission      provider      activity     downloadSpeed    uploadSpeed    postal_code    town_name
    ____________________    ________    ______    ______    ______    _________    _________    ______    __________________    ______    _____    __________    __________    ____________    _________    _____________    ___________    ___________    _________

    21-Dec-2016 00:00:00    12:04:16    42.112     2.774      20      "orange"     "JAZZTEL"      0       "STATE_IN_SERVICE"    "24.7"     18           3           NaN        "IN_VEHICLE"    "170157"          NaN              0          <missing>     <missing>
    21-Dec-2016 00:00:00    12:03:14    42.109    2.7777      15      "orange"     "JAZZTEL"      0       "STATE_IN_SERVICE"    "26.3"     18           3           NaN        "IN_VEHICLE"    "170157"          NaN              0          <missing>     <missing>
    21-Dec-2016 00:00:00    12:07:20    42.117    2.7649      13      "orange"     "JAZZTEL"      0       "STATE_IN_SERVICE"    "4.9"      14           3           NaN        "IN_VEHICLE"    "170157"          NaN              0          <missing>     <missing>
    21-Dec-2016 00:00:00    12:06:19    42.117    2.7659      13      "orange"     "JAZZTEL"      0       "STATE_IN_SERVICE"    "16.6"     14           3           NaN        "IN_VEHICLE"    "170157"          NaN              0          <missing>     <missing>
    21-Dec-2016 00:00:00    12:05:17    42.115    2.7684      15      "orange"     "JAZZTEL"      0       "STATE_IN_SERVICE"    "33.7"     18           3           NaN        "IN_VEHICLE"    "170157"          NaN              0          <missing>     <missing>




```

[//]: #  (Copyright 2020 The MathWorks, Inc.)
