# majority vote function
# given a integer vector of length 3, return the most common integer
# if all three integers are different, return 0
# possible integer are 1, 2, 3, 4

majority.vote <- function(vec){
  # make sure unique values are only 1,2,3,4
  uniqv <- unique(vec)
  if(!all(uniqv %in% c(1L, 2L, 3L, 4L))){
    stop("Illegal input")
  }
  if(length(uniqv) < length(vec)){
    return(uniqv[which.max(tabulate(match(vec, uniqv)))])
  } else {
    return (0)
  } 
}

# predict the G value based on multiple models (model number is odd number)
# Input: model.vec contains a list of models
#        test.df contains the dataframe for testing. test.df comes from preprocess() 
#        function
# Output: test.df that has retG value in each column

odd.model.pred <- function(model.list, test.df){
  pred.1 <- predict(model.list[[1]], test.df)
  pred.2 <- predict(model.list[[2]], test.df)
  pred.3 <- predict(model.list[[3]], test.df)
  predDF <- data.frame(pred.1, pred.2, pred.3)
  result <- apply(predDF, 1, majority.vote)
  result[which(result == 0)] <- test.df$G[which(result == 0)]
  return(result)
}

# test case
test.majority.vote <- function(){
  t1 <- c(1,1,2)
  if(majority.vote(t1) == 1){
    cat("passed test1\n")
  } else {
    cat("failed test1\n")
  }
  
  t2 <- c(1,2,3)
  if(majority.vote(t2) == 0){
    cat("passed test2\n")
  } else {
    cat("failed test1\n")
  }
  
  t3 <- c(1,3,3)
  if(majority.vote(t3) == 3){
    cat("passed test3\n")
  } else {
    cat("failed test1\n")
  }
  
}
test.majority.vote()
