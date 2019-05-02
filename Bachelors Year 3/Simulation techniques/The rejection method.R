f <- function(){
  while(TRUE) {
    u1 <- runif(1)
    u2 <- runif(1)
    y <- -3/2 * log(u1)
    x <- 0
    cont <- ((2/3) * exp(1)) ^ (1/2) * y ^ (1/2) * exp(1)^(-y/3)
    if(u2 <= cont) {
      x <- y
      break
    }
  }
  return (x)
}

N <- 10000
x <- numeric(N)
for(i in 1:N){
  x[i] = f()
}

t <- seq(0, 10, 0.001)
y <- dgamma(t, 3/2, 1)
hist(x, freq = FALSE, ylim = c(0, 0.6))
lines(t, y, col = "magenta")


f <- function(){
  x <- c(0.11,0.12,0.09,0.08,0.12,0.1,0.09,0.09,0.1,0.1)
  while(TRUE) {
    u <- runif(1)
    y <- sample(1:10, 1)
    z <- 0
    if(u <= x[y] / 0.12) {
      z <- y
      break
    }
  }
  return (z)
}

N <- 10000
x <- numeric(N)
for(i in 1:N){
  x[i] = f()
}

# Tema este anexata mailului sub forma de PDF
