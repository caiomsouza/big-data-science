#config-pdi-hive

## What you need?

* Hadoop correctly installed.
* Hive correctly instaled
* PDI downloaded

## Let's start.

1. Insert all this .jars files: hadoop-common-2.7.2.jar, hive-jdbc-2.0.0.jar, hive-service-2.0.0.jar, httpclient-4.4.jar, httpcore-4.4.jar, slf4j-api-1.7.7.jar, hive-exec-2.0.0.jar into data-integration/lib/

2. Copy the following file from Hive folder to hadoop-pdi sub-folder: ```cp -R /usr/local/hive/conf/ data-integration/plugins/pentaho-big-data-plugin/hadoop-configurations/hdp23```
```
hive-site.xml
```
3. Open plugin.proprierties file: ```nano data-integration/plugins/pentaho-big-data-plugin/plugin.properties```
	3.1 Edit the following line: ``` active.hadoop.configuration=hdp23 ```

For CDH 5.7.0
	3.1 Edit the following line: ``` active.hadoop.configuration=cdh55 ```

* Connection Type: Generic Database
* Custom Driver Class Name: org.apache.hive.jdbc.HiveDriver
* Custom Connection URL: jdbc:hive2://IP:10000/database
* User Name: hive
