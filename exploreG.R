
#### explore how result will change if G is correct 
#### based on those n shopping points ####
# this function returns the percentage of improvement in each shop_pt group
# after G letter was corrected
improve.G <- function(shop_pt, train.pt, equal.matrix){
  # find customer_ID who has two shopping points
  two.shop.pt <- train.pt$Group.1[which(train.pt$x == shop_pt)]
  # find index of those customers in equal.matrix
  indice.two <- match(two.shop.pt, rownames(equal.matrix))
  two.equal.count <- apply(equal.matrix[indice.two,], 1, all)
  two.equal.count.noG <- apply(equal.matrix[indice.two, -7], 1, all)
  percentage <- (length(which(two.equal.count.noG )) - 
                   length(which(two.equal.count ))) / length(two.equal.count)
  return(percentage)
}

# from 2 to 10, these integers are potential shopping 
# point candidate
for (i in (2:10)){
  print(improve.G(i, train.pt, equal.matrix))
}

