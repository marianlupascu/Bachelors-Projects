library(MASS)

#print
faithfulTable <- faithful
paintersTable <- painters

#frequency distribution of painting schools from data set "painters"
school <- painters$School
cbind(table(school))

#frequency distribution of eruption durations from data set "faithful"
duration <- faithful$eruptions
breaks <- seq(1.5, 5.5, by = 0.5)
duration.cut = cut(duration, breaks, right = FALSE)
duration.freq = table(duration.cut)
cbind(duration.freq)

#Two diffrent plots of the datasets
plot(painters)
plot(faithful$eruptions, faithful$waiting, xlab = "Eruptions", ylab = "Waiting")

#mean, meadian, variation, quantile and the boxplot of the eruption durations
mean(faithful$eruptions)
median(faithful$eruptions)
var(faithful$eruptions)
quantile(faithful$eruptions)
boxplot(faithful$eruptions)

#Corelation coef for the parameters in "faithful" dataset
cor(faithful$eruptions, faithful$waiting)


