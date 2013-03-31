library(ggplot2)
library(kernlab)

gather <- read.table("CodeIQ_data.txt",sep=" ")
names(gather) <- c("len1","len2")
gather["safety"] = c("d") # Dummy for plot
eaten <- read.table("CodeIQ_eaten.txt",sep=" ")
names(eaten) <- c("len1","len2","safety")

g = ggplot(rbind(gather,eaten),aes(x=len1,y=len2)) + geom_point(aes(color=safety))
print(g) # Check 3 types
browser()

# Create SVM
train.features = cbind(eaten$len1,eaten$len2)
train.labels = eaten$safety
predict.features = cbind(gather$len1,gather$len2)
classifier <- ksvm(
           train.features,
           train.labels,
           type="C-svc",
           kerel="rbfdot", # RBF kernel
           C=1
           )
gather["safety"] <- predict(classifier,predict.features)
g = ggplot(rbind(gather),aes(x=len1,y=len2)) + geom_point(aes(color=safety))
print(g) # Some safe mushrooms includes danger area.
browser()


# Modify parameter. 
classifier <- ksvm(
           train.features,
           train.labels,
           type="C-svc",
           kerel="rbfdot", # RBF kernel
           kpar=list(sigma = 0.7), 
           C=1
           )
gather["safety"] <- predict(classifier,predict.features)
g = ggplot(rbind(gather),aes(x=len1,y=len2)) + geom_point(aes(color=safety))
print(g) # There is a mistake.
browser()


# Add new sample (11.0,11.0) is 'o'
eaten.added <- rbind(eaten, list(11, 11, 'o'))
train.features.added = cbind(eaten.added$len1,eaten.added$len2)
train.labels.added = eaten.added$safety
classifier.added <- ksvm(
           train.features.added,
           train.labels.added,
           type="C-svc",
           kerel="rbfdot", # RBF kernel
           C=1
           )
gather["safety"] <- predict(classifier.added,predict.features)
g = ggplot(rbind(gather),aes(x=len1,y=len2)) + geom_point(aes(color=safety))
print(g) # Perfect!
browser()

write.table(gather,file="result.csv",row.names=F)