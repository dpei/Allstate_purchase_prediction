# Preprocess



# given a train data frame and specify column number, 
# return how many features does
# Input: a dataframe like train data
# Output: a customer_ID named vector with each number represents 
#         the numebr of changed features in the dataframe.
# each customer changed.
# Note: one customer can have 2 or more records.
feature.change.number <- function(train.df, column.ind){
  feature.matrix <- aggregate(cbind(train.df[, column.ind]), 
                              by = list(train.df$customer_ID), 
                              function(x){length(unique(x)) == 1})
  summary.individual <- ncol(feature.matrix) - 
    1 -
    apply(feature.matrix[,-1],1,sum)
  names(summary.individual) <- feature.matrix$Group.1
  return(summary.individual)
}


# Input: a train or test csv data frame, 
#        a indice vector in the which contains row number of two shopping point records
#        retG represent if retG is present in data frame (train == TURE, test == FALSE)
# Output: a data frame with only one shopping point for one 
#        individual. 
#         for train: shopping G as retG
#         for test: all retG as NA
preprocess <- function(input.df, indice, retG = TRUE){
  # Throw error message when input data frame is not having righ column
  colname.tf <- all(colnames(input.df)[c(1,16,22)] == c("customer_ID", "C_previous", "E"))
  ncol.tf <- ncol(input.df) == 25
  if(!(colname.tf & ncol.tf)){
    stop("the column number or column name is not in correct format")
  }
  
  # clean the train data with only customers having 2 shopping point
  train.model <- input.df[indice, ]
  
  # generate an additional variable:
  # number of change feature as 
  column <- setdiff(1:17, c(1,2,3,5))
  train.model$num.change <- feature.change.number(input.df[c(indice-1, 
                                                          indice),], 
                                                  column)
  
  # remove certain features 
  # Remove: customer_id, 
  # not sure: risk factor (too much NA)
  train.model <- train.model[ , -which(names(train.model) %in% 
                                         c("shopping_pt",
                                           "record_type", 
                                           "time",
                                           "C_previous", 
                                           "location",
                                           "risk_factor"))]
  
  # convert some class type
  train.model$homeowner <- as.logical(train.model$homeowner)
  train.model$married_couple <- as.logical(train.model$married_couple)
  
  # impute variable: duration_previous
  train.model$duration_previous[which(is.na(train.model$duration_previous))] <- median(train.model$duration_previous, na.rm = TRUE)
  
  # convert retG into factor for classification
  if(retG){
    train.model$retG <- train$G[indice+1]
    train.model$retG <- as.factor(train.model$retG)
  } else {
    train.model$retG <- NA
  }
  return(train.model)
}

# test case
test.preprocess <- function(){
  df <- read.table("~/Documents/alste/test/train_subset.txt", header = TRUE)
  purchase.point.indice.df <- which(df$record_type == 1)
  last.quote.indice.df <- purchase.point.indice.df - 1
  # create small data set
  df.train.model <- preprocess(df, last.quote.indice.df, TRUE)  
  # test if returned correct retG
  retG.tf <- all(df.train.model$retG[1:3] == c(1,2,1))
  change.G.tf <- !(df.train.model$G[11] == df.train.model$retG[11])
  no.change.G.tf <- all(df.train.model$G[-11] == df.train.model$retG[-11] )
  if (retG.tf & change.G.tf & no.change.G.tf){
    cat("passed test")
  } else {
    cat("failed test")
  }
}



test.preprocess()
