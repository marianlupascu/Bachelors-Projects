?gamma
?punif

v <- runif(10000000,0,1)
w <- runif(10000000,0,1)
g <- function(v) {
  (1 - v^2)^(3/2)
}
m1 <- mean(g(v))

h <- function(v) {
  exp((4*v -2) + (4*v - 2)^2 ) * 4
}
m2 <- mean(h(v))

i <- function(v, w) {
  exp((v - w)^2)
}
m3 <- mean(i(v, w))

gammma <- function(a) {
  -log(a)^9
}
m4 <- mean(gammma(v))

#----------------------Tema------------------------------
v <- runif(10000000,0,1)
cov(v, exp(v)) # 0.1408
m5 <- mean(v * exp(v)) - mean(v) * mean(exp(v)) #0.1408

sum <- 0
N <- 100000
for(i in 1:N){
  n <- 0
  while (n <= 1) {
    u <- runif(1,0,1)
    n <- n + u
  }
  sum <- sum + n
}
m6 <- sum / N
# pentru N = 100    => m6 = 1.35
# pentru N = 1000   => m6 = 1.36
# pentru N = 10000  => m6 = 1.36
# pentru N = 10 000 => m6 = 1.36

