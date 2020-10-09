# Authentication

To run the Google BigQuery™ client library, you must first set up authentication by creating or getting access to a Google cloud service account. The credentials(key) for the service account have to be saved as an environment variable on the local system.

*Note*: You need to set environment variables before starting a MATLAB instance for the environment variables to be effective.

## Getting Service account key:
1. In the [Cloud Console](https://console.cloud.google.com/), navigate to the [Create service account key page](https://console.cloud.google.com/apis/credentials/serviceaccountkey).
2. Select an existing Project or Create a new Project.
3. From the Service account list, select an existing service account or create a new service account.
4. If you have selected a New Service account, key in a name for the Service account name field.
5. From the Role list, select Project > Owner.
(Optional: Cloud Admin manages Roles for users. You will need EDITOR role for writing to cloud storage)

```Click Create. A JSON file that contains your key downloads to your computer.```

## Note:

The Role field authorizes your service account to access resources such as datasets, jobs etc. If you get permission issues while using this interface in MATLAB, you should look for the Role access for your Service Account within the selected Project. You can view and change this field later by using the [Cloud Console](https://console.cloud.google.com/). If you are developing a production app, specify more granular permissions than ```Project > Owner```.You might need to reach out to your cloud admin for accessing certain Roles.

For more information, see [BigQuery Roles](https://cloud.google.com/bigquery/docs/access-control#bigquery) for service accounts.

## Providing authentication credentials to your MATLAB application:
1. Place downloaded JSON file(credentials) at a local directory on your system. e.g.```..\Software\MATLAB\config```
```
{
  "type": "service_account",
  "project_id": "project-123REDACTED45",
  "private_key_id": "1378f5fREDACTED50eb2",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhBZv2fE=\n-----END PRIVATE KEY-----\n",
  "client_email": "467REDACTED5389-compute@developer.gserviceaccount.com",
  "client_id": "115REDACTED7232",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/46REDACTED5389-compute%40developer.gserviceaccount.com"
}
```
2. Rename the json file to a more readable format e.g. credentials.json

3. Add Environment Variable GOOGLE_APPLICATION_CREDENTIALS:

* UNIX:

```
>> export GOOGLE_APPLICATION_CREDENTIALS=../Software/MATLAB/config/credentials.json;
```

* WINDOWS:

  Navigate to ```Advanced System Settings >> Environment Variables```<sup>1</sup> and add new User variable ```GOOGLE_APPLICATION_CREDENTIALS``` with value "/project/location/Software/MATLAB/config/credentials.json"

![environment variable](images/Windows_env_var.png)

 Note: This environment variable only applies to your profile. If you need a less persistent way of setting credentials path, you can do so by setting the variables through shell and starting MATLAB from there.

4. To check whether credentials have been set correctly look for environment variable GOOGLE_APPLICATION_CREDENTIALS as follows
```
getenv("GOOGLE_APPLICATION_CREDENTIALS")

ans =

    '..\matlab-google-bigquery\Software\MATLAB\config\credentials.json'
```

## Usage

Note: Make sure you have followed the steps for [building the SDK](Installation.md) and have run the startup script, ```matlab-google-bigquery/Software/MATLAB/startup.m```, before moving ahead.

Here is how you can create a Google BigQuery client without explicitly mentioning the path to the credentials. The interface, by default, looks for the environment variable and carries out authentication. If the above steps haven't been performed, you might encounter an error.
```
gbqclient = gcp.bigquery.BigQuery();
```

You can also explicitly pass in a different set of credentials by passing the name(path) of(to) the credentials file as an input argument, as follows. Make sure the file is accessible to MATLAB. 
```
gbqclient = gcp.bigquery.BigQuery('credentials.json')
```
## Notes:

<sup>1</sup> Used with permission from Microsoft.

[//]: #  (Copyright 2020 The MathWorks, Inc.)
