library(MASS)

#student repartition
x = seq(0, 10, .1)

par(mfrow = c(2, 1))
curve(dt(x, 30), from = -5, to = 5, col = "orange", 
      xlab = "quantile", ylab = "density", lwd = 2, main = "student repartition")
curve(dt(x, 10), from = -5, to = 5, col = "dark green", add = TRUE, lwd = 2)
curve(dt(x, 5), from = -5, to = 5, col = "sky blue", add = TRUE, lwd = 2)
curve(dt(x, 1), from = -5, to = 5, col = "grey40", add = TRUE, lwd = 2)
legend("topleft", legend = paste0("DT = ", c(1, 5, 10, 30)),
       col = c("grey40", "sky blue", "dark green", "orange"),
       lty = 1, lwd = 2)

curve(pt(x, 10), from = -5, to = 5, col = "orange", lwd = 2)
curve(pt(x, 10), from = -5, to = 5, col = "dark green", add = TRUE, lwd = 2)
curve(pt(x, 5), from = -5, to = 5, col = "sky blue", add = TRUE, lwd = 2)
curve(pt(x, 1), from = -5, to = 5, col = "grey40", add = TRUE, lwd = 2)

#Example: Without assuming the population standard deviation of the student height in survey, find the margin of error and interval estimate at 95% confidence level.

#We first filter out missing values in survey$Height with the na.omit function, and save it in height.response

height.response = na.omit(survey$Height)

# We compute the sample standard deviation
n = length(height.response)
s = sd(height.response) # sample standard deviation
SE = s/sqrt(n); SE #standard error estimate

# Since there are two tails of the Student t distribution, the 95% confidence level would imply the 97.5th percentile of the Student t distribution at the upper tail. Therefore, tα∕2 is given by qt(.975, df=n-1). We multiply it with the standard error estimate SE and get the margin of error.

E = qt(.975, df=n-1)*SE; E #margin of error

#We then add it up with the sample mean, and find the confidence interval.

xbar = mean(height.response) # sample mean
xbar + c(-E, E)

# Without assumption on the population standard deviation, the margin of error for the student height survey at 95% confidence level is 1.3429 centimeters. The confidence interval is between 171.04 and 173.72 centimeters.

#fisher repartition
x = seq(0, 5, length = 100)

par(mfrow = c(2, 1))
curve(df(x, 5, 2), from = 0, to = 5, col = "orange", 
      xlab = "quantile", ylab = "density", lwd = 2, main = "fisher repartition")
curve(df(x, 5, 1), from = 0, to = 5, col = "dark green", add = TRUE, lwd = 2)
curve(df(x, 4, 3), from = 0, to = 5, col = "sky blue", add = TRUE, lwd = 2)
curve(df(x, 6, 4), from = 0, to = 5, col = "grey40", add = TRUE, lwd = 2)

curve(pf(x, 5, 2), from = 0, to = 5, col = "orange", lwd = 2)
curve(pf(x, 5, 1), from = 0, to = 5, col = "dark green", add = TRUE, lwd = 2)
curve(pf(x, 4, 3), from = 0, to = 5, col = "sky blue", add = TRUE, lwd = 2)
curve(pf(x, 6, 4), from = 0, to = 5, col = "grey40", add = TRUE, lwd = 2)

#Find the 95th percentile of the F distribution with (5, 2) degrees of freedom.
#We apply the quantile function qf of the F distribution against the decimal value 0.95.
qf(.95, df1=5, df2=2) 


#chisquare
x = table(survey$Smoke, survey$Exer)

par(mfrow = c(2, 1))
curve(dchisq(x, 5), from = 0, to = 20, col = "orange", 
      xlab = "quantile", ylab = "density", lwd = 2, main = "chisquare repartition")
curve(dchisq(x, 7), from = 0, to = 20, col = "dark green", add = TRUE, lwd = 2)
curve(dchisq(x, 8), from = 0, to = 20, col = "sky blue", add = TRUE, lwd = 2)
curve(dchisq(x, 10), from = 0, to = 20, col = "grey40", add = TRUE, lwd = 2)

curve(pchisq(x, 5), from = 0, to = 20, col = "orange", lwd = 2)
curve(pchisq(x, 7), from = 0, to = 20, col = "dark green", add = TRUE, lwd = 2)
curve(pchisq(x, 8), from = 0, to = 20, col = "sky blue", add = TRUE, lwd = 2)
curve(pchisq(x, 10), from = 0, to = 20, col = "grey40", add = TRUE, lwd = 2)

#Smoke - smoking habit, Exer - level of exercise 
#We can tally the students smoking habit against the exercise level with the table function in R. 
#The result is called the contingency table of the two variables.
ctbl = cbind(x[,"Freq"], x[,"None"] + x[,"Some"]) 
chisq.test(ctbl) 
