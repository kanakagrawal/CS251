data = read.csv("data_lin.csv")
x=data[,2]
y=data[,3]
X = matrix(1,length(x),2)
X[,2] = x
Y = matrix(1,length(y),1)
Y[,1] = y
B = solve(t(X)%*%X)%*%t(X)%*%Y
cat("slope =", B[2,1],"\n")
cat("y intercept =",B[1,1],"\n")
png(file = "taskB.png")
plot(x,y,col="red")
abline(a = B[1,1],b=B[2,1])
dev.off()