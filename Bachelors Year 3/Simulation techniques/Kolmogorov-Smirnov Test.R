#Kolmogorov-Smirnov
#testul ks se paote aplica numai pentru v.a. continue
#folosim un nivel de seminficatie alfa = 0.05
x <- 1:15
ks.test(x, "punif", 0, 16)
#cf testului acceptam ipoteza ca x reaprtizat uniform pe 0..16

ks.test(x, "punif", 1, 2000)
#cf testului NU acceptam ipoteza ca x reaprtizat uniform pe 1..2000

medie <- mean(x)
dispersie <- 14/15 * var(x)
ks.test(x, "pnorm", medie, sqrt(dispersie))
#cf testului acceptam ipoteza ca x reaprtizat gausian m = 8 si d = 4.32

#runtests - google