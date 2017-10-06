# the code chunk is used to write result into csv file for upload
# Generate testing result for those who only have two shopping point total 18943
# test.model$retG <- predict(modelFit, newdata = test.model)
# length(which(test.model$retG == test.model$G))
# dim(test.model)

# combine three models if applicable
test.model$retG <- odd.model.pred(list(modelFitRf, modelFitGbm, modelFitSvm), test.model)
length(which(test.model$retG == test.model$G))
dim(test.model)



# find index of last shopping point 
test.pt$index <- paste(test.pt$Group.1, test.pt$x)
test$index <- paste(test$customer_ID, test$shopping_pt)
join <- merge(test, test.pt, by = 'index')

# replace result G into predicted values
for(i in 1:nrow(test.model)){
  ind <- which(join$customer_ID == test.model$customer_ID[i])
  join$G[ind] <- test.model$retG[i]
}

# Export csv 
plan <- as.character(paste(join$A, 
                           join$B, 
                           join$C, 
                           join$D, 
                           join$E, 
                           join$F, 
                           join$G, 
                           sep = ""))
ret <- data.frame(customer_ID = join$customer_ID, 
                  plan = plan)
name <- paste("output/result_", date(), ".csv",sep = "")
write.csv(ret, file = name, row.names = FALSE)