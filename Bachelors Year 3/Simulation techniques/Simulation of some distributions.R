#simulare xn
n <- 10
x0 <- 99

x <- rep(0, n) #pe pozitia i tin x[i]
for(i in 1:n){
  if (i == 1) {
    aux <- x0^2
  } else {
    aux <- x[i-1]^2
  }
  print (i)
  print (aux)
  if (aux <= 9999 && aux >= 1000){
    rez <- (aux %/% 10) %% 100
  } else if (aux <= 999 && aux >= 100){
    rez <- aux %/% 10
  } else if (aux <= 99 && aux >= 10){
    rez <- aux %/% 10
  } else {
    rez <- 0
  }
  x[i] <- rez
}
xn <- x[n]

#identificare cicluri
for(i in 0:99){
  aux <- i^2
  if (aux <= 9999 && aux >= 1000){
    rez <- (aux %/% 10) %% 100
  } else if (aux <= 999 && aux >= 100){
    rez <- aux %/% 10
  } else if (aux <= 99 && aux >= 10){
    rez <- aux %/% 10
  } else {
    rez <- 0
  }
  if (rez == i)
    print(i)
}


# integrala de la 0 la Inf din e^(-x^2)
# schimbare de variabila t = (-1/x+1) + 1
sqrt(pi) / 2
v <- runif(10000000,0,1)
f <- function(x) {
  exp(-(-x / (x - 1))^2) * (1 / ((x - 1)^2))
}
m <- mean(f(v))
