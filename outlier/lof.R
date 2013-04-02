library(scatterplot3d)
library(DMwR)

hundred <- read.table("hundred.txt",header=F,sep=" ")
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

# LOF
outlier.scores <- lofactor(hundred, k = 3)
index = order(outlier.scores, decreasing = T)
top3 <- index[1:3]
print(top3)

label <- rep(T,length(index))
label[top3] <- F
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
write.table(hundred,file="result_lof.csv",row.names=F)