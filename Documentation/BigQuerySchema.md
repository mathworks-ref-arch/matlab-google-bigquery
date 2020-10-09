 ## Big Query Schema Support

Google BigQuery™ service allows one to specify a table's schema while loading data into it or while create an entirely new and empty table.
A table schema, typically involves each column's `name` and `datatype` and optionally a column's `description` and `mode`.

Datatype and mode support for a BigQuery dataset schema has been provided below:  

### Data Type
BigQuery standard & legacy SQL, lets you specify the following [datatypes](https://cloud.google.com/bigquery/docs/reference/standard-sql/data-types#datetime-type) in your schema.

|     Name            |  Big Query Data type	   |  MATLAB Supported Data type    |
|  -------------      |  ----------------------  |  --------------------------    |
|  `Integer`	        |      INT64	             |         int64                  |
|  `Floating point`	  |      FLOAT64	           |         double                 |
|  `Numeric`          |  	   NUMERIC      	     |         double                 |
|  `Boolean`	        |      BOOL        	       |         logical                |
|  `String`	          |      STRING	             |         string                 |
|  `Bytes`	          |      BYTES	             |         int8 <unsupported>     |
|  `Date`	            |      DATE	               |         datetime               |
|  `Date/Time`	      |      DATETIME	           |         string                 |
|  `Time`	            |      TIME	               |         duration               |
|  `Timestamp`	      |      TIMESTAMP   	       |         datetime               |
|  `Struct (Record)`	|      STRUCT	             |       `<unsupported>`          |
|  `Geography`	      |      GEOGRAPHY	         |       `<unsupported>`          |

[MATLAB documentation for supported JAVA return datatypes](https://www.mathworks.com/help/releases/R2019b/matlab/matlab_external/handling-data-returned-from-java-methods.html#bvi1br7-2)

### Handling BigQuery Table Data type Record

Accessing record fields by explicitly mentioning the record fields in the query.

Example dataset `bigquery-public-data.samples.github_nested`<sup>1</sup>

![SearchDatasets](Documentation/images/gbqrecord.PNG)

If an entire record `repository` is queried as follows, the return data type is not supported.
```
query = 'SELECT repository FROM `bigquery-public-data.samples.github_nested` LIMIT 10;';

queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
queryJobConfigurationBuilder = queryJobConfigurationBuilder.setUseLegacySql(false);
queryJobConfiguration = queryJobConfigurationBuilder.build;

tableResult = gbq.query(queryJobConfiguration);

% Extracting query results
mattable = gbq2table(tableResult)

Warning: no data to return due to unsupported formats or modes

mattable =

     []

```

Querying record `repository` and a non-record field `created_at` will return the non-record fields only.

```
query = 'SELECT repository, created_at FROM `bigquery-public-data.samples.github_nested` LIMIT 10;';

queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
queryJobConfigurationBuilder = queryJobConfigurationBuilder.setUseLegacySql(false);
queryJobConfiguration = queryJobConfigurationBuilder.build;

tableResult = gbq.query(queryJobConfiguration);

% Extracting query results
mattable = gbq2table(tableResult)

Warning: Some columns have been removed due to unsupported mode or datatype

mattable =

  10x1 table

            created_at         
    ___________________________

    "2012/03/30 02:17:15 -0700"
    "2012/03/30 02:36:01 -0700"
    "2012/03/25 06:25:05 -0700"
    "2012/03/25 06:32:28 -0700"
    "2012/03/24 14:24:31 -0700"
    "2012/03/28 07:25:51 -0700"
    "2012/03/28 07:37:43 -0700"
    "2012/03/27 11:45:08 -0700"
    "2012/03/31 15:17:01 -0700"
    "2012/03/27 06:16:51 -0700"
```

One can access fields within record such as `repository.url` 

```
query = 'SELECT repository.url, created_at FROM `bigquery-public-data.samples.github_nested` LIMIT 10;';

queryJobConfigurationBuilder =  gcp.bigquery.QueryJobConfiguration.newBuilder(query);
queryJobConfigurationBuilder = queryJobConfigurationBuilder.setUseLegacySql(false);
queryJobConfiguration = queryJobConfigurationBuilder.build;

tableResult = gbq.query(queryJobConfiguration);

% Extracting query results
mattable = gbq2table(tableResult)

mattable =

  10x2 table

                          url                                   created_at         
    ________________________________________________    ___________________________

    "https://github.com/liferay/liferay-plugins"        "2012/03/30 02:14:34 -0700"
    "https://github.com/plataformatec/simple_form"      "2012/03/30 02:48:40 -0700"
    "https://github.com/cakephp/datasources"            "2012/03/26 13:47:47 -0700"
    "https://github.com/ezsystems/ezfind"               "2012/03/30 02:57:38 -0700"
    "https://github.com/EightMedia/hammer.js"           "2012/03/25 06:39:29 -0700"
    "https://github.com/saasbook/hw3_rottenpotatoes"    "2012/03/24 14:06:47 -0700"
    "https://github.com/JetBrains/kotlin"               "2012/03/28 07:38:07 -0700"
    "https://github.com/php/php-src"                    "2012/03/27 06:13:51 -0700"
    "https://github.com/saasbook/hw4_rottenpotatoes"    "2012/03/20 15:40:50 -0700"
    "https://github.com/AFNetworking/AFNetworking"      "2012/03/20 15:44:47 -0700"

```

### Mode

BigQuery supports the following [modes](https://cloud.google.com/bigquery/docs/schemas#modes) for table columns. Mode is an optional requirement while specifying table schema. If the mode is unspecified, the column defaults to NULLABLE.


Mode	     |      Support          |        Description                                            |
--------   |     --------------    |    ---------------------------------------------------------- |
`Nullable` |	      supported      |      Column allows NULL values (default)                      |
`Required` |	      supported      |      NULL values are not allowed                              |
`Repeated` |	    `<unsupported>`  |      Column contains an array of values of the specified type |


## Notes:

<sup>1</sup> Portions of this page are modifications based on work created and shared by Google and used according to terms described in the Creative Commons 4.0 Attribution License.


[//]: #  (Copyright 2020 The MathWorks, Inc.)