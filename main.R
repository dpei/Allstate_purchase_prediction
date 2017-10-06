# this code chunk read in train data, test data. It also explores the options A-G.


setwd("~/Documents/alste")
# loading in data
train <- read.csv("~/Documents/alste/raw/train.csv", header = TRUE)
test <- read.csv("~/Documents/alste/raw/test_v2.csv", header = TRUE)
source("~/Documents/alste/preprocess.R")
source("~/Documents/alste/majority.vote.R")
# for train dataset, calculate a data matrix of correct prediction based on 
# last shopping point.
purchase.point.indice <- which(train$record_type == 1)
last.quote.indice <- purchase.point.indice - 1


# the x column in train.pt is the largest number of shopping point without buying
train.no.purchase <- train[train$record_type != 1, ]
train.pt <- aggregate(train.no.purchase$shopping_pt, 
                      by = list(train.no.purchase$customer_ID), 
                      max)
# print max shopping point before purchase for individuals. test set
test.pt <- aggregate(test$shopping_pt, by = list(test$customer_ID), max)
test.pt$index <- paste(test.pt$Group.1, test.pt$x)




# prepare train model 
# preprocess() is a user defined function
# call function to get data frame for model Only keep those with two shopping indices
two.shoppt.indice <- last.quote.indice[train$shopping_pt[last.quote.indice] %in% c(2,3)]
train.model <- preprocess(train, two.shoppt.indice, TRUE)





# predict two AND three AND four individuals because it yields good result
twonthree.pt.individual <- test.pt$Group.1[which(test.pt$x %in% c(2,3,4))]
test$index <- paste(test$customer_ID, test$shopping_pt)
test.twonthree.shoppt.indice <- match(test.pt$index[which(test.pt$Group.1 %in% twonthree.pt.individual)], 
                                      test$index)
test <- read.csv("~/Documents/alste/raw/test_v2.csv", header = TRUE)
test.model <- preprocess(test, test.twonthree.shoppt.indice, FALSE)



# keep some objects in R
# rm(list= ls()[!(ls() %in% c('train','test',
#                             'modelFitGbm', 'modelFitSvm','modelFitRf',
#                             'train.model', 'test.model'
#                             ))])
# save result
save.image("result.RData")
