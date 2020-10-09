#  Use with MATLAB Production Server and MATLAB Compiler

When using the package with MATLAB Production Server™ or MATLAB Compiler™ one normally uses the respective Compiler GUIs accessible within the MATLAB IDE. 
There are three points to note when deploying applications in this way:    
1. Paths are normally configured using the *startup.m* script in the */Software/MATLAB/* directory. When deploying an application that calls this package the paths are not configured in that way and the startup script will have no effect. No end user action is required in this regard.    

2. A .jar file can be found in *matlab-gcp-common/Software/MATLAB/lib/jar/*, this file includes the required functionality from the google-cloud-bigquery™ Java SDK. The automatic dependency analysis will not pick this up and it must be added manually as an additional file.

3. For testing purposes adding the `credentials JSON file` manually just like the jar(mentioned above) is a simple way to include credentials in the deployed code. While the JSON file will be encrypted it will be included in the compiler output which may be shared. This may violate local security polices and best practices. One should consider other approaches of providing credentials to deployed applications. One should also consider avoiding a scenario which involves credentials being included in source code repositories where they may be exposed.


[//]: #  (Copyright 2020 The MathWorks, Inc.)
