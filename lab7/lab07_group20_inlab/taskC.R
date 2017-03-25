data = read.csv("data_non_lin.csv")
y=data[,3]
x1=data[,2]
x2=x1*x1
relation = lm(y~x1+x2)
y_estimate = relation$coefficients[1] + relation$coefficients[2]*x1 + relation$coefficients[3]*x2
error = (y_estimate-y)*(y_estimate-y)
a = sum(error)
cat("error lm =",a,"\n")
cat("const =",relation$coefficients[1],"\n")
cat("coeffx =",relation$coefficients[2],"\n")
cat("coeffx2 =",relation$coefficients[3],"\n")
png(file = "taskC.png")
plot(x1,y,col="red")
xg=seq(min(x1)-1,max(x1)+1,by=0.01)
lines(xg,relation$coefficients[1] + relation$coefficients[2]*xg + relation$coefficients[3]*xg*xg, col = "blue")
dev.off()