#generare de numere aleatoare
n <- 1000
y <- rpois(n, 1)
hist(y, col = "green", freq = FALSE)
points(0:6, dpois(0:6, 1), col = "red")

n <- 10000
z <- rnorm(n)
hist(z, col = "green", freq = FALSE, nclass = 20)
t <- seq(-5, 5, 0.001)
lines(t, dnorm(t), col = "red")

?hist

#generare pi
n <- 10000
u <- runif(n, -1, 1)
v <- runif(n, -1, 1)
k <- 0

plot(0, 0, col = "green")

for(i in 1:n){
  if(u[i]^2 + v[i]^2 <= 1) {
    points(u[i], v[i], col = "green")
    k <- k + 1
  }else
    points(u[i], v[i], col = "red")
}

pi <- k * 4 / n

#aproximare e
a <- ppois(1, 1) / 2
e1 <- 1 / a

b <- pexp(2, 1/2)
c <- 1 - b
e2 <- 1 / c