
https://bigdatagames.wordpress.com/2013/12/11/star-schema-in-hive/

http://www.semantikoz.com/blog/star-schema-hive-impala/


CREATE TABLE public.fct_sentiment_analysis (
	sk_sentiment INTEGER,
	num_positive INTEGER,
	num_negative INTEGER,
	final_score INTEGER,
	source_id INTEGER,
	date_sk INTEGER,
	text_message TEXT,
	search_words TEXT
);




Hive


INSERT INTO table tablename1 select columnlist FROM secondtable;

INSERT INTO TABLE tweet_table
  SELECT  "my_data" AS my_column
    FROM   pre_loaded_tbl
   LIMIT   5;



   create table foo (id int, name string);


   create table dummy_table_name as select * from source_table_name;


   create table dummy_table_name as select * from source_table_name;

create table fct_sentiment_analysis
(pc_date STRING)



create table stg_twitter
(pc_date STRING)
