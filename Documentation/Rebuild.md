# Building the Interface

Before using the interface for Google BigQuery™, it is required to build a jar using Maven™.
The ```matlab-gcp-common``` houses the ```pom.xml``` file with dependencies which can be found in: ```matlab-gcp-common/Software/Java/```. Maven requires that a JDK (Java® 7 or later) is installed and that the *JAVA_HOME* environment variable is set to the location of the JDK. On Windows® the *MAVEN_HOME* environment variable should also be set. Consult the Maven documentation for further details.

Use the following commands or operating system specific equivalents to perform a maven build of the package's jar file.
```
$ cd matlab-gcp-common/Software/Java
$ mvn clean verify package
```

The pom file currently references version *1.99.0* of the google-cloud-bigquery SDK:
```
    <dependency>
        <groupId>com.google.cloud</groupId>
        <artifactId>google-cloud-bigquery</artifactId>
        <version>1.99.0</version>
    </dependency>
```

To build with a more recent version of the SDK, amend the pom file to a specific version or use the following syntax to allow maven to select a newer version. Caution, this may result in build or runtime issues.
```
<dependency>
  <groupId>com.google.cloud</groupId>
  <artifactId>google-cloud-bigquery</artifactId>
  <version>[1.99.0,)</version>
  <type>pom</type>
  <scope>import</scope>
</dependency>
```    

The output of the build is a JAR file that is placed in ```matlab-gcp-common/Software/MATLAB/lib/jar``` folder for use by MATLAB.

Once the jar is built, use the ```mathworks-gcp-support/matlab-google-bigquery/Software/MATLAB/startup.m``` function to initialize the interface.
```MATLAB
cd('mathworks-gcp-support/matlab-google-bigquery/Software/MATLAB')
startup
```
The package is now ready for use.


[//]: #  (Copyright 2020 The MathWorks, Inc.)
