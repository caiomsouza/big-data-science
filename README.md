# Big Data Science

This project was created to join the power of Apache Hadoop/Hive + R/RStudio.

# Environment Tested
The Environment used to this test was: <BR>
* RStudio Version 0.99.902
* R version 3.3.1 (2016-06-21)

# Hadoop
* CDH 5.7.0 - Cloudera Release Notes
* https://www.cloudera.com/documentation/enterprise/release-notes/topics/cdh_vd_cdh_package_tarball_57.html#concept_0vc_ddn_yk
* Apache Hadoop (hadoop-2.6.0+cdh5.7.0+1280)
* Apache Hive (hive-1.1.0+cdh5.7.0+522)


# R Version
```
> version
               _                           
platform       x86_64-w64-mingw32          
arch           x86_64                      
os             mingw32                     
system         x86_64, mingw32             
status                                     
major          3                           
minor          3.1                         
year           2016                        
month          06                          
day            21                          
svn rev        70800                       
language       R                           
version.string R version 3.3.1 (2016-06-21)
nickname       Bug in Your Hair            
>
```

# Sample Code to connect Apache Hive + RStudio  
```
gc()
rm(list = ls())

setwd("~/GitHub/caiomsouza/big-data-science")

#install.packages("RJDBC",dep=TRUE)

library(RJDBC)

#Load Hive JDBC driver
hivedrv <- JDBC("org.apache.hive.jdbc.HiveDriver",
                c(list.files("libs/hadoop",pattern="jar$",full.names=T),
                  list.files("libs/hive",pattern="jar$",full.names=T)))

# jdbc:hive2://192.168.0.29:10000/default
# org.apache.hive.jdbc.HiveDriver
# user: hive
# password: empty


#Connect to Hive service
#hivecon <- dbConnect(hivedrv, "jdbc:hive2://192.168.0.29:10000/default")
hivecon <- dbConnect(hivedrv, "jdbc:hive2://192.168.0.29:10000/default", "hive", "")

# Table: customers
query = "select * from customers LIMIT 10"
hres <- dbGetQuery(hivecon, query)

head(hres)
class(hres)

# Table: web_logs
query = "select * from web_logs LIMIT 10"
hres <- dbGetQuery(hivecon, query)

head(hres)
class(hres)

# Table: power_consumptions
query = "select * from power_consumptions LIMIT 10"
hres <- dbGetQuery(hivecon, query)

head(hres)
class(hres)
```

# RStudio + Hive

![RStudio + Hive](https://github.com/caiomsouza/big-data-science/blob/master/printscreen/rstudio_hive_query_web_logs.PNG)

# CDH 5.7.0
![CDH 5.7.0](https://github.com/caiomsouza/big-data-science/blob/master/printscreen/cdh_query_web_logs.PNG)


# Troubleshooting

During the test I had the error below:

```
> hivecon <- dbConnect(hivedrv, "jdbc:hive2://192.168.0.29:10000/default")
SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
SLF4J: Defaulting to no-operation (NOP) logger implementation
SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
Error in .jcall(drv@jdrv, "Ljava/sql/Connection;", "connect", as.character(url)[1],  :
                  java.sql.SQLException: Could not establish connection to jdbc:hive2://192.168.0.29:10000/default: Required field 'client_protocol' is unset! Struct:TOpenSessionReq(client_protocol:null, configuration:{use:database=default})
                >
```

# The problem was solved using the correct Hive JDBC
* https://www.cloudera.com/documentation/enterprise/release-notes/topics/cdh_vd_cdh_package_tarball_57.html#concept_0vc_ddn_yk
* https://issues.apache.org/jira/browse/HIVE-6050
