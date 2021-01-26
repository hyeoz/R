install.packages('readxl')
library(readxl)
rogo1 <- read.csv("/Users/hyewonlee/Documents/Coding/Python/Crawling/rogo_gall.csv")
rogo2 <- read.csv("/Users/hyewonlee/Documents/Coding/Python/Crawling/rogo_gall2.csv")
rogo3 <- read.csv("/Users/hyewonlee/Documents/Coding/Python/Crawling/rogo_gall3.csv")
rogo4 <- read.csv("/Users/hyewonlee/Documents/Coding/Python/Crawling/rogo_gall4.csv")
rogo5 <- read.csv("/Users/hyewonlee/Documents/Coding/Python/Crawling/rogo_gall5.csv")

head(rogo1)
str(rogo1)

rogo <- rbind(rogo1, rogo2,rogo3,rogo4,rogo5)
str(rogo)

rogo_title <- rogo["title"]
head(rogo_title)
str(rogo_title)

remotes::install_github('haven-jeon/KONLP', upgrade = 'never', force = TRUE, INSTALL_opts=c('--no-multiarch'))
library(KoNLP)
install.packages('NIADic')
library(NIADic)
install.packages('RmecabKo')
library(RmecabKo)
Yes
install.packages('RColorBrewer')
library(RColorBrewer)
install.packages('wordcloud2')
library(wordcloud2)
install.packages("dplyr")
library(dplyr)
install.packages("rJava")
install.packages("memoise")
install.packages("stringr")
library(rJava)
library(memoise)
library(stringr)
install.packages("reshape2")
library(reshape2)

title <- as.list(rogo_title)
title <- unlist(title)
class(title)

#전체 반응 워드클라우드 그리기
raw <- SimplePos09(title)
raw
class(raw)
data <- unlist(raw)
head(data)

data <-str_match(data, '([가-힣]+)/N')
class(data)
head(data,10)

data <- data[,2]
data <- Filter(function(x) {nchar(x) >= 2}, data)
str(data)
data1 <- na.omit(data)
data1

str(data1)

word <- table(data1)
word
str(word)


wordcount_1 <- sort(word, decreasing = TRUE)
wordcount_1 <- wordcount_1[2:50]


wordcloud2(wordcount_1, gridSize = 1, size = 0.5, shape = './rogo_image.png')
wordcloud2(wordcount_1, gridSize = 1, size = 0.5, shape = './rogo_image.png')

