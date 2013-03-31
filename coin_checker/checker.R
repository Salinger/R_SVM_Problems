library(ggplot2) # For Plot
library(kernlab) # For SVM

auth = read.table("./CodeIQ_auth.txt",header=F,sep=" ")
names(auth) <- c("volume","weight","truth") # 0 is Fake

my_coins = read.table("./CodeIQ_mycoins.txt",header=F,sep=" ")
names(my_coins) <- c("volume","weight")

g = ggplot(auth,aes(x=volume,y=weight)) + geom_point(aes(color=truth))
print(g)
browser() # Check train data

# Create SVM train data
train.features = cbind(auth$volume,auth$weight)
train.labels = auth$truth
predict.features <- cbind(my_coins$volume,my_coins$weight)

classifier <- ksvm(
           train.features,
           train.labels,
           type="C-svc",
           kerel="vanilladot", # Liner kernel
           C=1
           )

my_coins["truth"] <- predict(classifier,predict.features)
print(my_coins$truth)
write.table(my_coins ,file="result.csv",row.names = F)

# Plot result
my_coins$truth[my_coins$truth == 0] <- 2 # 2 is predicted Fake
my_coins$truth[my_coins$truth == 1] <- 3

result <- rbind(auth,my_coins) 
result$truth <- factor(result$truth, levels = c(0,1,2,3))

g = ggplot(result,aes(x=volume,y=weight)) + geom_point(aes(color=truth))
print(g)
