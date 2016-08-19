#config-biserver-hive

## What do you need?

* Hadoop correctly installed.
* Hive correctly instaled
* biserver downloaded

## Let's start.

1. Insert all this .jars files:

hadoop-common-2.7.2.jar,
hive-jdbc-2.0.0.jar,
hive-service-2.0.0.jar,
httpclient-4.4.jar,
httpcore-4.4.jar,
slf4j-api-1.7.7.jar,
hive-exec-2.0.0.jar

into biserver-ce/tomcat/lib/

2. Copy the following file from Hive folder to hadoop-pdi sub-folder:

```cp -R /usr/local/hive/conf/ biserver-ee/pentaho-solutions/system/kettle/plugins/pentaho-big-data-plugin/hadoop-configurations/hdp22
```

hive-site.xml

For (CDH 5.7.0)

```
cp -R /usr/lib/hive/conf/ biserver-ee/pentaho-solutions/system/kettle/plugins/pentaho-big-data-plugin/hadoop-configurations/cdh55
```


3. Open plugin.proprierties file: ```nano biserver-ee/pentaho-solutions/system/kettle/plugins/pentaho-big-data-plugin/plugin.properties```

For Apache Hadoop
	3.1 Edit the following line: ``` active.hadoop.configuration=hdp22 ```

For CDH 5.7.0
	3.1 Edit the following line: ``` active.hadoop.configuration=cdh55```
