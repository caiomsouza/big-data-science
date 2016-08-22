# Hive Commands

How to login, show databases, use database, show tables, drop table and exit hive command line:

```
$ hive
```

Output:
```
[cloudera@quickstart ~]$ hive
2016-08-21 16:16:38,059 WARN  [main] mapreduce.TableMapReduceUtil: The hbase-prefix-tree module jar containing PrefixTreeCodec is not present.  Continuing without it.

Logging initialized using configuration in file:/etc/hive/conf.dist/hive-log4j.properties
WARNING: Hive CLI is deprecated and migration to Beeline is recommended.
```

Show databases, use and show tables;
```
hive> show databases;
OK
default
warehouse
Time taken: 0.824 seconds, Fetched: 2 row(s)
hive> use warehouse;
OK
Time taken: 0.064 seconds
hive> show tables;
OK
Time taken: 0.053 seconds
```

Use the database and show tables;
```
hive> use default;
OK
Time taken: 0.024 seconds
hive> show tables;
OK
customers
power_consumptions
power_consumptions10
power_consumptions2
power_consumptions20
power_consumptions3
power_consumptions5
power_consumptions_hive
power_consumptions_hive3
power_consumptions_impala
power_consumptions_impala2
power_consumptions_impala34
power_consumptions_impala35
power_consumptions_impala39
power_consumptions_impala49
power_consumptions_new
sample_07
sample_08
twitter_json01
web_logs
Time taken: 0.031 seconds, Fetched: 20 row(s)
```

Drop table
```
hive> drop table power_consumptions20;
OK
Time taken: 1.975 seconds
hive> drop table power_consumptions_new;
OK
Time taken: 0.171 seconds
hive> drop table power_consumptions_impala49;
OK
Time taken: 0.165 seconds
```

Exit Hive Command Line
```
hive> exit;
WARN: The method class org.apache.commons.logging.impl.SLF4JLogFactory#release() was invoked.
WARN: Please see http://www.slf4j.org/codes.html#release for an explanation.
```
