require(caret)

# data("iris")
# write.csv(train.model[1:1000,], "~/Documents/alste/test/classification.csv", row.names = FALSE)
# train.model.small <- read.csv("~/Documents/alste/test/classification.csv", header = TRUE)
#train.model.small$retG <- as.factor(train.model.test$retG)
# try to use features predict G change
# train.model$Gchange <- train.model$G == train.model$retG
# train.model$Gchange <- as.factor(train.model$Gchange)
# option 2
dataset <- train.model
pred <- "retG"


colnames(dataset)[which(names(dataset) %in% pred)] <- "outcome"
set.seed(1235)
inTrain <- createDataPartition(y=dataset$outcome, p=0.75, list = FALSE)
training <- dataset[inTrain,]
testing <- dataset[-inTrain,]

cat(paste("the dimension of records is ", 
          dim(training)[1], " * ", dim(training)[2],
          "\n",
          sep = ""))



# cross validation
trctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

# record system time while store model fit result into data
# 16min for 4177 records rf method
# tried to adjust parameters, not working good.
system.time(modelFitRf <- train(outcome~.,
                              method = "rf",
                              data = training ,
                              trControl = trctrl,
                              metric = "Accuracy",
                              preProcess = c("center", "scale")))

# knn method currently abolished because too much modifications
# system.time(modelFitKnn <- train(outcome ~.,
#                  data = training,
#                  method = "knn",
#                  trControl=trctrl,
#                  preProcess = c("center", "scale"),
#                  tuneLength = 10))

# gbm method costs 5 minutes to run on 4177 items
system.time(modelFitGbm <- train(outcome ~., 
                  data=training, 
                  method="gbm", 
                  trControl=trctrl, 
                  preProcess = c("center", "scale"),
                  verbose=FALSE))


#svm method
system.time(modelFitSvm <- train(outcome ~., 
                              data = training, 
                              method = "svmLinear",
                              trControl=trctrl,
                              preProcess = c("center", "scale"),
                              tuneLength = 10))


# Below are validation set for one model
# result <- predict(modelFit, newdata = testing)
# accurate <-  result == testing$outcome

# below are validation set for majority vote of three models
result <- odd.model.pred(list(modelFitRf, modelFitGbm, modelFitSvm), testing)
accurate <- result == testing$outcome



cat("Model accuracy in validation set is: ")
sum(accurate)/length(accurate)
cat("prediction table is")
table(accurate, testing$outcome)
cat("percent of G been changed")
length(which(!testing$G == result))/nrow(testing)*100


