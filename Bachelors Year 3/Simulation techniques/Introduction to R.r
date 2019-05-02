#reaprtita normala
#gerare de valori dintr-o normala stadard
rnorm(10)
t <- seq(-5, 5, 0.01)
plot(t, dnorm(t), col="magenta")
 
for (i in 2:5) {
  lines(t, dnorm(t, i-4), col = i)
}
 
for (i in 2:5) {
  lines(t, dnorm(t, 0, i), col = i, ylim = c(0, 1), xlim = c(-6, 6))
}
 
lines(t, dnorm(t, 0, 0.5), col = "black")

#-----------------TEMA--------------------------

?round
?plot
?runif
#Tema Ex1
# pot face inversele in mod numeric ca mai jos deoarece 
# imaginea functie este egala cu preimaginea, fiind o bijectie pe [0, 1]
f1 <- function(p) {
  (p^5 + p^3 + p) / 3
}

x <- seq(0, 1, 0.001)
y <- f1(x)
z <- seq(0, 1, 0.001) * 0

for(i in 1 : 1001) {
  if(round(y[i]*1000) == 0){
    z[i] = x[i]
  } else {
    z[round(y[i]*1000)] = x[i]
  }
}

prev = z(1);
for(i in 1: 1001){
  if (z[i] == 0) {
    z[i] <- prev
  }
  prev <- z[i]
}

plot(x,  z)

u <- runif(100)
x <- z[round(u, 3)*1000]
hist(x, freq = FALSE)

#Tema Ex2

f2 <- function(p) {
  (1 - exp(1)^(-2*x) + 2*x) / 3
}

x <- seq(0, 1, 0.001)
y <- f2(x)
z <- seq(0, 1, 0.001) * 0

for(i in 1 : 1001) {
  if(round(y[i]*1000) == 0){
    z[i] = x[i]
  } else {
    z[round(y[i]*1000)] = x[i]
  }
}

prev = z(1);
for(i in 1: 1001){
  if (z[i] == 0) {
    z[i] <- prev
  }
  prev <- z[i]
}

plot(x,  z)

u <- runif(100)
x <- 1:100 * 0
for(i in 1:100) {
  if(u[i] < 1) {
    x <- z[round(u, 3)*1000]
  } else {
    u[i] <- -log(3 - 3*u) / 2
  }
}
hist(x, freq = FALSE)