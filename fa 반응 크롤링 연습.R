#필요한 패키지 설치
install.packages('base64enc')
library(base64enc)
remotes::install_github('haven-jeon/KONLP', upgrade = 'never', force = TRUE, INSTALL_opts=c('--no-multiarch'))
library(KoNLP)
install.packages('NIADic')
library(NIADic)
install.packages('RmecabKo')
library(RmecabKo)
install.packages('rtweet')
library(rtweet)
install.packages('tidyverse')
library(tidyverse)
install.packages('igraph')
library(igraph)
install.packages('twitteR')
library(twitteR)
install.packages('RColorBrewer')
library(RColorBrewer)
install.packages('wordcloud2')
library(wordcloud2)
install.packages('RmecabKo')
install.packages('tidyverse')
install.packages('readxl')
library(readxl)
install.packages('reshape2')
library(reshape2)

#트위터 api key 설정
api_key <- 'njmocKxo733pTSBhsBoHF0P4A'
api_secret_key <- 'k1L4NoJcLdiXdEkO7uhr86YOjuPRvxxLy69gG8UmBeL1WZBM2C'
access_token <- '1242442364934688768-QhyNCDv4HEveXp9v8BYSro84K0wC7E'
access_token_secret <- 'DyyojZPrGucrwvrnj0IsYxQuxUUDNqTRJwWfGXzeitc6o'
options(httr_oauth_cache = TRUE) #r을 온라인으로 연결
setup_twitter_oauth(api_key,api_secret_key,access_token,access_token_secret)

#키워드 설정
keyword_1 <- enc2utf8('주환')
keyword_2 <- enc2utf8('최주환')


#크롤링
fa_1 <- searchTwitter(keyword_1, n = 500, lang = 'ko', since = '2020-12-11', until = '2020-12-12')
head(fa_1)
fa_1_df <- twListToDF(fa_1)
length(fa_1)
fa_2 <- searchTwitter(keyword_2, n = 500, lang = 'ko', since = '2020-12-11', until = '2020-12-12')
head(fa_2)
fa_2_df <- twListToDF(fa_2)

head(fa_2_df)
col(fa_1_df)

#텍스트만 가져오기 
fa_1_df <- fa_1_df$text
fa_2_df <- fa_2_df$text
head(fa_1_df)
head(fa_2_df)

#정리
fa_1_df_word <- Filter(function(x) {nchar(x) <= 50}, fa_1_df)
head(fa_1_df_word)
fa_2_df_word <- Filter(function(x) {nchar(x) <= 50}, fa_2_df)
head(fa_2_df_word)


tran1 <- Map(SimplePos09, fa_1_df_word)
head(tran1)
tran2 <- Map(SimplePos09, fa_2_df_word)
head(tran2)

fa_1 <- tran1 %>%
  melt() %>%
  tibble::as_tibble()
fa_2 <- tran2 %>%
  melt() %>%
  tibble::as_tibble()

head(fa_1)
head(fa_2)

fa_1_명사 <- fa_1 %>%  
  mutate(명사=str_match(value,'([가-힣]+)/N')[,2]) %>%                         
  na.omit() %>%                                     
  mutate(글자수=str_length(명사)) %>%    
  filter(str_length(명사)>=2)  
fa_2_명사 <- fa_2 %>%  
  mutate(명사=str_match(value,'([가-힣]+)/N')[,2]) %>%                         
  na.omit() %>%                                     
  mutate(글자수=str_length(명사)) %>%    
  filter(str_length(명사)>=2) 
 
install.packages('dplyr')
library(dplyr)
install.packages('stringr')
library(stringr)

fa_1_명사 <- fa_1_명사$L2
fa_1_명사
fa_2_명사 <- fa_2_명사$L2
fa_2_명사

str(fa_1_명사)
head(fa_1_명사)

getwd()
setwd('/Users/hyewonlee/Documents/')
txt <- readLines('gsub_fa.txt')
txt
cnt_txt <- length(txt)
cnt_txt

fa_1 <- as.list(fa_1_명사)
fa_2 <- as.list(fa_2_명사)
head(fa_1)

for( i in 1:cnt_txt) {
  fa_1 <- gsub((txt[i]),"",fa_1)
}
for( i in 1:cnt_txt) {
  fa_2 <- gsub((txt[i]),"",fa_2)
}

head(fa_1)
head(fa_2)

fa_1 <- Filter(function(x) {nchar(x) <= 10}, fa_1)
fa_1 <- Filter(function(x) {nchar(x) >= 2}, fa_1)
fa_2 <- Filter(function(x) {nchar(x) <= 10}, fa_2)
fa_2 <- Filter(function(x) {nchar(x) >= 2}, fa_2)
fa_1 <- unlist(fa_1)
fa_2 <- unlist(fa_2)

#워드클라우드 그리기
wordcount_1 <- table(fa_1)
wordcount_1 <- sort(wordcount_1, decreasing = TRUE)
wordcount_1 <- wordcount_1[1:30]
head(wordcount_1)
wordcount_2 <- table(fa_2)
wordcount_2 <- sort(wordcount_2, decreasing = TRUE)
wordcount_2 <- wordcount_2[1:30]
head(wordcount_2)

wordcloud2(wordcount_1, gridSize = 1, size = 0.5, shape = 'circle')
wordcloud2(wordcount_2, gridSize = 1, size = 0.5, shape = 'circle')




