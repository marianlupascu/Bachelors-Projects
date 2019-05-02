N <- 1000
c <- c(0.2, 0.15, 0.25, 0.4)
u <- runif(N)
r <- 1:N * 0
r2 <- 1:N * 0

# Varianta 1
count1 <- 0
for(i in 1:N){
  if(u[i] < c[1]){
    r[i] <- 1
    count1 <- count1 + 1
  }else
    if(u[i] < c[1] + c[2]) {
      r[i] <- 2
      count1 <- count1 + 2
    }else
      if(u[i] < c[1] + c[2] + c[3]) {
        r[i] <- 3
        count1 <- count1 + 3
      }else {
        r[i] <- 4
        count1 <- count1 + 3
      }
}
count1

# Varianta 2
count2 <- 0
for(i in 1:N){
  if(u[i] < c[4]){
    r2[i] <- 4
    count2 <- count2 + 1
  }else
    if(u[i] < c[4] + c[3]) {
      r2[i] <- 3
      count2 <- count2 + 2
    }else
      if(u[i] < c[4] + c[3] + c[1]) {
        r2[i] <- 1
        count2 <- count2 + 3
      }else {
        r2[i] <- 2
        count2 <- count2 + 3
      }
}
count2

length(r[r == 1]) / length(r)
length(r[r == 2]) / length(r)
length(r[r == 3]) / length(r)
length(r[r == 4]) / length(r)
rr <- sample(1:4, size=N, prob = c, replace=TRUE)
length(rr[rr == 1]) / length(rr)
length(rr[rr == 2]) / length(rr)
length(rr[rr == 3]) / length(rr)
length(rr[rr == 4]) / length(rr)

length(r2[r2 == 1]) / length(r2)
length(r2[r2 == 2]) / length(r2)
length(r2[r2 == 3]) / length(r2)
length(r2[r2 == 4]) / length(r2)
length(rr[rr == 1]) / length(rr)
length(rr[rr == 2]) / length(rr)
length(rr[rr == 3]) / length(rr)
length(rr[rr == 4]) / length(rr)

sample(1:4) 
y <- c(1:5, 3:6)
sample(y)
sample(1:4, size=3)
sample(1:4, size=3, replace=TRUE)
s <- sample(y, size=900, replace=TRUE) # doar 1, 2 si 6 au prob 1/9, in timp ce 2,4 si 5 au 2/9
length(s[s == 1]) / length(s)
length(s[s == 2]) / length(s)
length(s[s == 3]) / length(s)
length(s[s == 4]) / length(s)
length(s[s == 5]) / length(s)
length(s[s == 6]) / length(s)

t <- sample(1:4, size=100, prob=c(0.2, 0.15, 0.25, 0.4), replace=TRUE)
length(t[t == 1]) / length(t)
length(t[t == 2]) / length(t)
length(t[t == 3]) / length(t)
length(t[t == 4]) / length(t)
