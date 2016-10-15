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
#hivecon <- dbConnect(hivedrv, "jdbc:hive2://192.168.0.28:10000/default")
hivecon <- dbConnect(hivedrv, "jdbc:hive2://192.168.0.28:10000/default", "hive", "")

query = "ADD JAR /home/cloudera/git-repos/cdh-twitter-example/hive-serdes/target/hive-serdes-1.0-SNAPSHOT.jar"
hres <- dbGetQuery(hivecon, query)

# Table: customers
query = "select * from tweets_json2 LIMIT 10"
hres <- dbGetQuery(hivecon, query)

head(hres)
class(hres)

head(hres$tweets_json2.id)
head(hres$tweets_json2.user)
head(hres$tweets_json2.text)


# Table: Tweets Tech Words
query = "select lower(tweets_techwords.text) tweets from tweets_techwords LIMIT 1000"
hres <- dbGetQuery(hivecon, query)

head(hres)
class(hres)

head(hres$tweets)


### Sentiment Analysis

#setwd("~/git/Bitbucket/u-tad/tfm-v3/src/r")

# http://thinktostart.com/sentiment-analysis-on-twitter/
# https://jeffreybreen.wordpress.com/2011/07/04/twitter-text-mining-r-slides/

#http://www.r-bloggers.com/mining-twitter-for-consumer-attitudes-towards-hotels/

# https://cran.r-project.org/web/packages/twitteR/twitteR.pdf



#library(devtools)
#install_github("twitteR", username="geoffjentry")

#install.packages("ROAuth")
#install.packages("RCurl")
#install.packages("bitops")
#install.packages("digest")
#install.packages("rjson")
#install.packages("twitteR")

library(twitteR)
library(plyr)
library(ROAuth)
library(bitops)
library(digest)
library(rjson)

#1.	ExtracciÃ³n de los datos de Twitter.


tweets <- hres$tweets
class(tweets)

tweets.df <- data.frame(tweets)
class(tweets.df)


# Convert The Tweets List to Data Frame
#tweets.df <- twListToDF(tweets)
tweets.df
write.csv(tweets.df, file = "tweets_test.csv")

tweets.df$tweets

# FunciÃ³n para limpiar los datos
clean.text <- function(some_txt)
{
  some_txt = gsub("&amp", "", some_txt)
  some_txt = gsub("(RT|via)((?:\b\\W*@\\w+)+)", "", some_txt)
  some_txt = gsub("@\\w+", "", some_txt)
  some_txt = gsub("[[:punct:]]", "", some_txt)
  some_txt = gsub("[[:digit:]]", "", some_txt)
  some_txt = gsub("http\\w+", "", some_txt)
  some_txt = gsub("[ t]{2,}", "", some_txt)
  some_txt = gsub("^\\s+|\\s+$", "", some_txt)
  
  # define "tolower error handling" function
  try.tolower = function(x)
  {
    y = NA
    try_error = tryCatch(tolower(x), error=function(e) e)
    if (!inherits(try_error, "error"))
      y = tolower(x)
    return(y)
  }
  some_txt = sapply(some_txt, try.tolower)
  some_txt = some_txt[some_txt != ""]
  names(some_txt) = NULL
  return(some_txt)
}


clean_text = clean.text(tweets.df$tweets)

#3.	Cargar en memoria el Lexicon (Diccionario de Palabras positivas y Negativas).


# en = Wordbank en ingles | pt01 = Wordbank en portugues con SentiLex-PT01 | pt02 = Wordbank en portugues con SentiLex-PT02
version <- "en";

if (version == "en") {
  
  # Wordbanks from https://github.com/mjhea0/twitter-sentiment-analysis/tree/master/wordbanks
  pos = scan('~/GitHub/caiomsouza/u-tad-eds-proyecto-final/lexicon/wordbanks/positive-words.txt', what='character', comment.char=';')
  neg = scan('~/GitHub/caiomsouza/u-tad-eds-proyecto-final/lexicon/wordbanks/negative-words.txt', what='character', comment.char=';')
  head(pos)
  head(neg)
  
} else if(version == "pt01"){
  
  # SentiLex-PT01
  pos = scan('~/GitHub/caiomsouza/u-tad-eds-proyecto-final/lexicon/SentiLex-PT01/pos-pt01.txt', what='character', comment.char=';')
  neg = scan('~/GitHub/caiomsouza/u-tad-eds-proyecto-final/lexicon/SentiLex-PT01/neg-pt01.txt', what='character', comment.char=';')
  head(pos,20)
  head(neg,20)
  
  
} else if (version == "pt02") {
  
  # SentiLex-PT02
  pos = scan('~/GitHub/caiomsouza/u-tad-eds-proyecto-final/lexicon/SentiLex-PT02/pos.txt', what='character', comment.char=';')
  neg = scan('~/GitHub/caiomsouza/u-tad-eds-proyecto-final/lexicon/SentiLex-PT02/neg.txt', what='character', comment.char=';')
  head(pos,20)
  head(neg,20)
  
}

#4.	FunciÃ³n para hacer la analice de sentimiento.

score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  require(plyr)
  require(stringr)
  
  # we got a vector of sentences. plyr will handle a list
  # or a vector as an "l" for us
  # we want a simple array ("a") of scores back, so we use 
  # "l" + "a" + "ply" = "laply":
  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    
    # clean up sentences with R's regex-driven global substitute, gsub():
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    # and convert to lower case:
    sentence = tolower(sentence)
    
    # split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    # sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    
    # compare our words to the dictionaries of positive & negative terms
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    
    # match() returns the position of the matched term or NA
    # we just want a TRUE/FALSE:
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    
    # and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
    score = sum(pos.matches) - sum(neg.matches)
    
    return(score)
  }, pos.words, neg.words, .progress=.progress )
  
  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
}

# Ejecuta el sentiment score algorithm to calculate the sentiment
analysis = score.sentiment(clean_text, pos, neg)

analysis$score

# VisualizaciÃ³n
table(analysis$score)
mean(analysis$score)
hist(analysis$score)
colnames(analysis)
View(analysis)

head(analysis)

# Nube de Palabras
#install.packages(c("wordcloud","tm"),repos="http://cran.r-project.org")
library(tm)
library(wordcloud)
require(plyr)

tweet_corpus = Corpus(VectorSource(clean_text))
tdm = TermDocumentMatrix(tweet_corpus, 
                         control = list(removePunctuation = TRUE, stopwords = c("machine", "learning", stopwords("english")), 
                                        removeNumbers = TRUE, tolower = TRUE))
m = as.matrix(tdm) #we define tdm as matrix

word_freqs = sort(rowSums(m), decreasing=TRUE) #now we get the word orders in decreasing order
dm = data.frame(word=names(word_freqs), freq=word_freqs) #we create our data set
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2")) #and we visualize our data
png("~/git/Bitbucket/u-tad/final-project/src/r-script/CloudDilma6Feb16.png", width=12, height=8, units="in", res=300)
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))
dev.off()
