# print how many result will be corrected if change a letter
# or two letter
# or three letters

letter <- colnames(equal.matrix)

for (i in 1:7){
  equal.count <- apply(equal.matrix[,-i], 1, all)
  cat(paste("if all correct all letter ", letter[i],sep = ""))
  number <- sum(equal.count)/length(equal.count)
  cat(paste(": ", number, "\n", sep = ""))
}

two <- combn(1:7, 2)
three <- combn(1:7, 3)
four <- combn(1:7, 2)


for (i in 1:ncol(two)){
  indice <- c(two[1,i], two[2,i])
  equal.count <- apply(equal.matrix[,-indice], 1, all)
  cat("if all corrected letter(s) are: ")
  cat(paste(letter[indice], " ", sep = ""))
  number <- sum(equal.count)/length(equal.count)
  cat(paste(number, "\n", sep = ""))
}


for (i in 1:ncol(three)){
  indice <- c(three[1,i], three[2,i], three[3,i])
  equal.count <- apply(equal.matrix[,-indice], 1, all)
  number <- sum(equal.count)/length(equal.count)
  if(number>0.79){
    cat("if all corrected letter(s) are: ")
    cat(paste(letter[indice], " ", sep = ""))
    cat(paste(number, "\n", sep = ""))  
  }
}
