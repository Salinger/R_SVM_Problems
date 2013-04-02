library(scatterplot3d)

hundred <- read.table("hundred.txt",header=F,sep=" ")
names(hundred) <- c("weight","shc","ref")
# Scaling for calcurating distances
scaled <- as.data.frame(
    scale(as.matrix(hundred), center = TRUE, scale = TRUE)
    )

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


# k-means method
num.cluster <- 2
try <- 50
cluster <- kmeans(scaled,num.cluster,nstart=try)
centers <- cluster$centers[cluster$cluster,]
index <- order(rowSums((scaled - centers)^2),decreasing=TRUE)
top5 <- index[1:5]
label <- rep(T,length(index))
label[top5] <- F
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
write.table(hundred,file="result_kmeans.csv",row.names=F)