# Author: Caio Moreno 
# September, 24, 2016

# Environment Tested
# RStudio Version 0.99.902
# R version 3.3.1 (2016-06-21)

# Hadoop
# CDH 5.7.0 - Cloudera Release Notes
# https://www.cloudera.com/documentation/enterprise/release-notes/topics/cdh_vd_cdh_package_tarball_57.html#concept_0vc_ddn_yk
# Apache Hadoop (hadoop-2.6.0+cdh5.7.0+1280)
# Apache Hive (hive-1.1.0+cdh5.7.0+522)

gc()
rm(list = ls())

setwd("~/GitHub/caiomsouza/big-data-science")

#install.packages("RJDBC",dep=TRUE)

library(RJDBC)


#Load Hive JDBC driver
hivedrv <- JDBC("org.apache.hive.jdbc.HiveDriver",
                c(list.files("drivers/cdh55/hadoop",pattern="jar$",full.names=T),
                  list.files("drivers/cdh55/hive",pattern="jar$",full.names=T)))

# jdbc:hive2://192.168.0.29:10000/default
# org.apache.hive.jdbc.HiveDriver
# user: hive
# password: empty


#Connect to Hive service
#hivecon <- dbConnect(hivedrv, "jdbc:hive2://192.168.0.29:10000/default")
hivecon <- dbConnect(hivedrv, "jdbc:hive2://192.168.0.29:10000/default", "hive", "")

query = "ADD JAR /home/cloudera/git-repos/cdh-twitter-example/hive-serdes/target/hive-serdes-1.0-SNAPSHOT.jar"
hres <- dbGetQuery(hivecon, query)

# Table: customers
query = "select * from tweets_json2 LIMIT 10"
hres <- dbGetQuery(hivecon, query)

head(hres)
class(hres)

head(hres$tweets_json2.id)
head(hres$tweets_json2.user)
head(hres$tweets_json2.user)




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