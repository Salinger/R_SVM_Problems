library(scatterplot3d)
library(kernlab)

hundred <- read.table("hundred.txt",header=F,sep=" ")
#hundred <- as.data.frame(scale(as.matrix(hundred.raw),center=T,scale=T))
names(hundred) <- c("weight","shc","ref")

# Test plot
g = scatterplot3d(
  x=hundred$weight,
  y=hundred$shc,
  z=hundred$ref,
  highlight.3d = TRUE,
  pch = 20,
  type = "h"
  )
print(g)
browser()

# 1-class SVM
#   For optimizing nu parameter
svm <- function(d,nu){
    classifier <- ksvm(
        as.matrix(d),
        type ="one-svc",
        kernel="rbfdot",
        nu=nu
        )
    p = predict(classifier)
    return(which(p == F))
}
#   Return outlier index frequencies
outlier <- function(d){
    counter <- numeric(length(d$weight))
    for(nu in seq(0.01,0.2,by=0.005)){
        result <- svm(d,nu)
        counter[result] = counter[result] + 1
    }
    return(counter)
} 

outlier.count <- outlier(hundred)
result.index <- order(-outlier.count)[1:5] # Top 5
print(result.index)
label <- rep(T,length(outlier.count))
label[result.index] <- F
hundred["label"] = label
browser()

#Plot outliers
result.t <- hundred[hundred$label == T,]
result.f <- hundred[hundred$label == F,]
lim.x <- c(max(hundred$weight),min(hundred$weight))
lim.y <- c(max(hundred$shc),min(hundred$shc))
lim.z <- c(max(hundred$ref),min(hundred$ref))
g = scatterplot3d(
    x=result.t$weight,
    y=result.t$shc,
    z=result.t$ref,
    xlim = lim.x,
    ylim = lim.y,
    zlim = lim.z,
    xlab = "Weight[g]",
    ylab = "Specific heat capacity[J/(Kg x K)]",
    zlab = "Reflectivity[%]",
    pch = 20,
    type = "h",
    color = "red",
    )
par(new = T) 
g = scatterplot3d(
    x=result.f$weight,
    y=result.f$shc,
    z=result.f$ref,
    xlim = lim.x,
    ylim = lim.y,
    zlim = lim.z,
    xlab = "",
    ylab = "",
    zlab = "",
    pch = 20,
    type = "h",
    color = "blue",
    )
print(g)
browser()

# Output
write.table(hundred,file="result.csv",row.names=F)