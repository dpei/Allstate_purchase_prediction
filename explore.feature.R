# explore what feature changed in different shopping groups
# a test case
agt <- read.table("~/Documents/alste/test/aggregate_feature.txt", header = TRUE)
aggregate(cbind(agt$value1, agt$value2), by = list(agt$group), function(x){length(unique(x)) == 1})
aggregate(cbind(agt[,2:3]), by = list(agt$group), function(x){length(unique(x)) == 1})

# based on customer ID, aggregate features based on equal value
# if all values are the same, then return true
# if not all values a re the same, then return false
cbind(6 , 72 , 23:26, data=train)

id.equal <- aggregate(train$state, by = list(train$customer_ID), function(x){length(unique(x)) == 1})

# the result feature matrix has 97009 rows represent each customer,
# the result feature matrix has several columns represent features,
# the velues in the feature matrix can be TRUE or FALSE
# if the value is true, that means during all shopping point, this value
# does not change in the customer, Otherwise, false means change.
column <-setdiff(1:17, c(1,2,3,5))
colnames(train)[column]
feature.matrix <- aggregate(cbind(train[, column]), 
                            by = list(train$customer_ID), 
                            function(x){length(unique(x)) == 1})
# summary feature shows how many people changed a feature vs not changed a feature
summary.feature <- apply(feature.matrix,2,table)
# summary.individual is a vector of numbers 
# each number represents how many variables were changed during the 
# quote process.
summary.individual <- ncol(feature.matrix) - 1 -
                      apply(feature.matrix[,-1],1,sum)
names(summary.individual) <- feature.matrix$Group.1


# perform a anova test between people who change vs who don't change feature
# check if there G value has changed
df <- data.frame(summary.individual)
df$G <- FALSE
df$G[change.G] <- TRUE

# With more number of change, it is more likely to change G
# change of number and corresponding change of percentage.s
#[1] 0.08362731 0.15252395 0.17850242 0.20268081 0.22776968 0.24212598
#[7] 0.27595628 0.33913043 0.31428571 0.28571429
# chi square showed significance.
number.change.G <- aggregate(df$G, by = list(df$summary.individual), sum)$x
number.nochange.G <- aggregate(!df$G, by = list(df$summary.individual), sum)$x
chisq.test(as.table(rbind(number.change.G, number.nochange.G)))

# determin how many feature changed in first two records (fast customer and slow customer)
# below are all 97009 customer with first two records
second.ind <- which(train$shopping_pt %in% c(1,2))
table(feature.change.number(train[second.ind,], column))
# below are customers with only three shopping points (fast customer)
second.ind <- intersect(which(train$shopping_pt == 3), which(train$record_type == 1))
table(feature.change.number(train[c(second.ind-1, second.ind-2),], column))

# explore how good the second record G option predict final purchase point G option
second.ind <- c(which(train$shopping_pt == 2), which(train$record_type == 1))
tmp.train <- train[second.ind,]
ret <- aggregate(tmp.train$G, 
                 by = list(tmp.train$customer_ID), 
                 function(x){length(unique(x)) == 1})
ret$purchase_point <- train$shopping_pt[which(train$record_type == 1)] 
# code below shows how good the second G predicts the purchase point (last shopping point) G
aggregate(ret$x, by = list(ret$purchase_point), sum) / aggregate(ret$x, by = list(ret$purchase_point), length)
