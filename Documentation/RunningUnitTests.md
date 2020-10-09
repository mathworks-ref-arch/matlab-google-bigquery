# Running Unit Tests

After completing [Installation steps](Installation.md) and [Authentication steps](Authentication.md), the API setup can be tested using the Unit Tests that come along with this API.

Before running the tests make sure you have the following:
* A file named as `credentials.json` on path with valid Google Cloud Service Account credentials
* Installed [MATLAB Interface for Google Cloud Storage](https://github.com/mathworks-ref-arch/matlab-google-cloud-storage)
* A Google Cloud Project
* Enabled BigQuery and Cloud Storage APIs on Google cloud console for the Google Cloud Project
* Permissions and ROLES for read/write/list/delete

Use the following MATLAB commands to run the unit tests:
```MATLAB
cd('mathworks-gcp-support/matlab-google-bigquery/Software/MATLAB')
startup

cd('test\unit\');runtests()

ans = 

  1×14 TestResult array with properties:

    Name
    Passed
    Failed
    Incomplete
    Duration
    Details

Totals:
   14 Passed, 0 Failed, 0 Incomplete.
   74.7701 seconds testing time.

```

The package is now ready for use.


[//]: #  (Copyright 2020 The MathWorks, Inc.)
