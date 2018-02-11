library(MASS)

#We could not find the "Auto" dataset 
Auto <- Cars93

#Help visulise if there are any linear relationships between the variables 
scatter.smooth(x = Auto$Horsepower, y = Auto$Fuel.tank.capacity, main = "Horsepower / Fuel.tank.capacity")

#Check for outliers(any datapoint that lies outside the 1.5 * interquartile-range(1.5 * IQR))
#IQR - the distance between the 25th percentile and 75th percentile values for the vars.
par(mfrow = c(1, 2))
boxplot(Auto$Horsepower, main = "Horsepower")
boxplot(Auto$Fuel.tank.capacity, main = "Fuel.tank.capacity")

#Check if the response variable is close to normality
par(mfrow = c(1, 2))
plot(density(Auto$Horsepower), main = "Density Plot: Horsepower")
polygon(density(Auto$Horsepower), col = "green")
plot(density(Auto$Fuel.tank.capacity), main = "Density Plot: Fuel.tank.capacity")
polygon(density(Auto$Fuel.tank.capacity), col = "pink")

#Check the correlation (>0.70 therefore they have a good relationship)
#it's a little bit less than 0.75, srry :'( 
#But they still have a good relationship if not a strong one 
cor(Auto$Horsepower, Auto$Fuel.tank.capacity)

#Build Linear Model
linearModel <- lm(Fuel.tank.capacity ~ Horsepower, data = Auto)

#Interpret if the linear model is statistically significat
#Both the model p-Value and the p-VAlue of individual predictor vars
#Are less than the pre-determine dstatistical significance level(0.05)
# => the linear model is statistically significant 
modelSummary <- summary(linearModel)
modelCoefficients <- modelSummary$coefficients
beta.estimate <- modelCoefficients["Horsepower", "Estimate"]  # get beta estimate for Horsepower
std.error <- modelCoefficients["Horsepower", "Std. Error"]  # get std.error for Horsepower
t_value <- beta.estimate/std.error  # calculate t statistic
p_value <- 2*pt(-abs(t_value), df=nrow(Auto)-ncol(Auto))  # calculate p Value
AIC(linearModel)
BIC(linearModel)
#t statistic > 1.96 (for p value < 0.05)
#std.error = 0.0046(close to zero)
#AIC >= 419.1569
#BIC >= 424.8929

