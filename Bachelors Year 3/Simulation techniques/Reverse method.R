#Ex 0
u <- runif(1)
n <- 2
x <- u^(1/2)

#Ex 1
u <- runif(100)
lambda <- 7
x <- -1/lambda * log(u)
hist(x, freq = FALSE)
t <- seq(0, 1, 0.001)
lines(t, dexp(t, lambda), col = "magenta")

#Ex 2
for(i in 1:1000) {
  u <- runif(10)
  lambda <- 7
  x <- -(1/lambda) * log(u)
  y[i] <- sum(x)
}
hist(y, freq = FALSE)
t <- seq(0, 20, 0.0001)
lines(t, dgamma(t, 10, lambda), col = "magenta")


 


