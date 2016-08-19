#config-pdi-hadoop

## What do you need?

* Hadoop correctly installed.
* PDI downloaded

## Let's start.

1. Copy pdi folder to hduser: ```sudo cp -R data-integration /home/hduser/Downloads/```
2. Change to hduser: ``` su hduser ```
3. Change the pdi folder permission ```sudo chmod -R 777 data-integration```
4. Copy the following files from Hadoop folder to hadoop-pdi sub-folder:

``` cp -R /usr/local/hadoop/etc/hadoop/ data-integration/plugins/pentaho-big-data-plugin/hadoop-configurations/hdp23
```

or

```cp -R /usr/local/hadoop/etc/hadoop/ data-integration/plugins/pentaho-big-data-plugin/hadoop-configurations/cdh55
```


	```
	core-site.xml
	yarn-site.xml
	hdfs-site.xml
	```
5. Open plugin.proprierties file: ```nano data-integration/plugins/pentaho-big-data-plugin/plugin.properties```
	5.1 Edit the following line: ``` active.hadoop.configuration=hdp23 ```

For CDH 5.7.0

	5.1 Edit the following line: ``` active.hadoop.configuration=cdh55 ```


6. Edit spoon.sh: ```nano data-integration\spoon.sh```
	6.1 add this line: ```set HADOOP_USER_NAME="hduser"```
