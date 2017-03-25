png(file = "taskA.png")
data= read.csv("data.csv")
y= data[,3]
x= data[,2]
plot(x,y)
abline(h=c(mean(y),median(y),mean(y)-sd(y),mean(y)+sd(y)),col=c("red","blue","green","green"),lwd=2)
relation <- lm(y~x)
abline(a=relation$coefficients[1],b=relation$coefficients[2],col="brown",lty=4,lwd=2)
legend(min(x),max(y), legend=c("fit","Mean","Median","sigma_bar"),col=c("brown","red","blue","green"), lwd=2,lty=c(4,1,1,1))
cat("mean =",mean(y),"\n")
cat("median =",median(y), "\n")
cat("standard deviation =",sd(y),"\n")
cat("slope =",relation$coefficients[2],"\n")
cat("y intercept =",relation$coefficients[1],"\n")
yest=relation$coefficients[1]+relation$coefficients[2]*x
error=yest-y
error=error^2
error=sum(error)
cat("error =",error,"\n")
dev.off()