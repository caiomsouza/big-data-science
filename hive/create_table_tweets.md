# Create table Tweets

```
ADD JAR /home/cloudera/git-repos/cdh-twitter-example/hive-serdes/target/hive-serdes-1.0-SNAPSHOT.jar;

CREATE  External TABLE tweets_json2 (
  id BIGINT,
  created_at STRING,
  source STRING,
  favorited BOOLEAN,
retweet_count INT,
  retweeted_status STRUCT<
    text:STRING,
    user:STRUCT<screen_name:STRING,name:STRING>,
    retweet_count:INT>,
  entities STRUCT<
    urls:ARRAY<STRUCT<expanded_url:STRING>>,
    user_mentions:ARRAY<STRUCT<screen_name:STRING,name:STRING>>,
    hashtags:ARRAY<STRUCT<text:STRING>>>,
  text STRING,
  user STRUCT<
    screen_name:STRING,
    name:STRING,
    friends_count:INT,
    followers_count:INT,
    statuses_count:INT,
    verified:BOOLEAN,
    utc_offset:INT,
    time_zone:STRING>,
  in_reply_to_screen_name STRING
)
ROW FORMAT SERDE 'com.cloudera.hive.serde.JSONSerDe'
LOCATION '/user/cloudera/stage/DITRD-v1.0.2/';




ADD JAR /home/cloudera/git-repos/cdh-twitter-example/hive-serdes/target/hive-serdes-1.0-SNAPSHOT.jar;

CREATE  External TABLE tweets_techwords (
  id BIGINT,
  created_at STRING,
  source STRING,
  favorited BOOLEAN,
retweet_count INT,
  retweeted_status STRUCT<
    text:STRING,
    user:STRUCT<screen_name:STRING,name:STRING>,
    retweet_count:INT>,
  entities STRUCT<
    urls:ARRAY<STRUCT<expanded_url:STRING>>,
    user_mentions:ARRAY<STRUCT<screen_name:STRING,name:STRING>>,
    hashtags:ARRAY<STRUCT<text:STRING>>>,
  text STRING,
  user STRUCT<
    screen_name:STRING,
    name:STRING,
    friends_count:INT,
    followers_count:INT,
    statuses_count:INT,
    verified:BOOLEAN,
    utc_offset:INT,
    time_zone:STRING>,
  in_reply_to_screen_name STRING
)
ROW FORMAT SERDE 'com.cloudera.hive.serde.JSONSerDe'
LOCATION '/user/cloudera/stage/flume-tweets/tech-words/';

select * from tweets_techwords limit 10;


ADD JAR /home/cloudera/git-repos/cdh-twitter-example/hive-serdes/target/hive-serdes-1.0-SNAPSHOT.jar;

CREATE  External TABLE tweets_dilma3 (
  id BIGINT,
  created_at STRING,
  source STRING,
  favorited BOOLEAN,
retweet_count INT,
  retweeted_status STRUCT<
    text:STRING,
    user:STRUCT<screen_name:STRING,name:STRING>,
    retweet_count:INT>,
  entities STRUCT<
    urls:ARRAY<STRUCT<expanded_url:STRING>>,
    user_mentions:ARRAY<STRUCT<screen_name:STRING,name:STRING>>,
    hashtags:ARRAY<STRUCT<text:STRING>>>,
  text STRING,
  user STRUCT<
    screen_name:STRING,
    name:STRING,
    friends_count:INT,
    followers_count:INT,
    statuses_count:INT,
    verified:BOOLEAN,
    utc_offset:INT,
    time_zone:STRING>,
  in_reply_to_screen_name STRING
)
ROW FORMAT SERDE 'com.cloudera.hive.serde.JSONSerDe'
LOCATION '/user/cloudera/stage/flume-tweets/';

select * from tweets_dilma3 limit 10;

```

# HDFS
```
hadoop fs -ls /user/cloudera/stage/DITRD-v1.0.2

hadoop fs -put oozie-workflows/ /user/cloudera/oozie-workflows

hdfs dfs -ls hdfs://quickstart.cloudera:8020/user/cloudera/stage/flume-tweets/tech-words

hdfs dfs -mkdir hdfs://quickstart.cloudera:8020/user/cloudera/stage/flume-tweets/tech-words

hdfs dfs -chmod -R g+r hdfs://quickstart.cloudera:8020/user/cloudera/stage


```
