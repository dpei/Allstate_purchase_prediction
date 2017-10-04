# explorative analysis in how people choose the options

equal.matrix <- train[purchase.point.indice, 18:24] == train[last.quote.indice, 18:24]
rownames(equal.matrix) <- train$customer_ID[purchase.point.indice]
# function below shows the percentage of correct prediction in train data
# 0.68 correction based on last shopping point
equal.count <- apply(equal.matrix, 1, all)
sum(equal.count)/length(equal.count)

# function below shows how many letter options are correctly predicted
# G     F     A     C     B     E     D 
# 83835 89970 90115 90293 90617 90942 92082 
option.change.count <- apply(equal.matrix, 2, sum)
option.change.count[order(option.change.count)]
option.change.count[order(option.change.count)]/length(equal.count)


hist(test.pt$x)
# print max shopping point before purchase for individuals. train set

hist(train.pt$x)

# make sure the last column in train dataset is the last shopping point
all(train.pt$x == train[last.quote.indice, 2])




# find out true prediction rate in different shopping point group
true.pred.quote.num <- aggregate(equal.count, by = list(train.pt$x),sum)
quote.num <- table(train.pt$x)
if(all(true.pred.quote.num$Group.1 == names(quote.num))){
  plot(true.pred.quote.num$x/as.numeric(quote.num) ~  names(quote.num),
       ylab = "correct prediction rate",
       xlab = "number of shopping points",
       type = "n")
  text(true.pred.quote.num$x/as.numeric(quote.num) ~  names(quote.num), 
       label=as.numeric(quote.num))
}

# How many 1, 2, 3, 4 in G category, last quote vs purchase point
table(train$G[purchase.point.indice])
table(train$G[last.quote.indice])
table(train$G[purchase.point.indice]) - table(train$G[last.quote.indice])

# How many changed G among all 97009 individuals ?
# a total of 13174 individuals changed their G (13.5% change)
length(which(train$G[purchase.point.indice] != train$G[last.quote.indice]))
change.G <- which(train$G[purchase.point.indice] != train$G[last.quote.indice])
train$G[purchase.point.indice[change.G]]
train$G[last.quote.indice[change.G]]

# compared mean and variance of expense there is no big difference.
var(train[purchase.point.indice, 25])
var(train[last.quote.indice, 25])

train$customer_ID[last.quote.indice[change.G]]