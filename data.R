library(MASS)

n = 100

Sigma1 <- matrix(c(5,3,3,2),2,2)
group1 = cbind(mvrnorm(n = n, c(7,9), Sigma1), rep(1,n))

Sigma2 <- matrix(c(5,3,3,11),2,2)
group2 = cbind(mvrnorm(n = n, c(11,7), Sigma2), rep(2,n))

Sigma3 <- matrix(c(5,1,2,3),2,2)
group3 = cbind(mvrnorm(n = n, c(3,1), Sigma3), rep(3,n))

X = data.frame(rbind(group1,group2,group3))
colnames(X) <- c("x","y", "class")

plot(X[['x']]~X[['y']], col=X[['class']])

res1=X
library(rjson)
x <- toJSON(unname(split(res1, 1:nrow(res1))))
cat(x)