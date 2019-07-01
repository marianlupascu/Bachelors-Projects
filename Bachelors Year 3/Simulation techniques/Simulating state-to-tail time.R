startTime <- 10 # hours
endTime <- 20 # hours
minTimeServing <- 2*60 # seconds
maxTimeServing <- 7*60 # seconds
disc <- 10000 # threshold of meshing
currentTime <- startTime
N_arrivals <- 0
N_departures <- 0
NumberPeopleInQueue <- 0
ArrivalsLogs = c()
DeparturesLogs = c()
ExtraTimeLogs = c()
TimeSpentInTheSystemLogs = c()


getServingTime <- function(){
  return (runif(1, minTimeServing, maxTimeServing))
}

getIntensityFunctionOfThePoissonProcess <- function(){
  t <- seq(0, endTime + 2, 1/disc)
  y <- c((3*(t[t <= 6 + startTime] - startTime) + 1), (14 + 0*t[t > 6 + startTime])) # func 3
  hist(y[(startTime * disc + 1):(endTime * disc + 1)], 
       freq = FALSE, 
       xlab = "Number of clients")
  plot(t[(startTime * disc + 1):(endTime * disc + 1)], 
       y[(startTime * disc + 1):(endTime * disc + 1)], 
       col = "magenta", main = "Function Of The Poisson Process",
       xlab = "hours", ylab = "Number of clients in that moment")
  return (y / 3600) # the likelihood that a customer will appear every second
}

# Ts = the first time after the moment s
simulareTs <- function(s, lambda){
  lambdaMax = max(lambda[(startTime * disc + 1):(endTime * disc + 1)])
  t <- s
  while(1){
    u1 <- runif(1)
    t <- t - log(u1) / lambdaMax
    u2 <- runif(1)
    if(u2 < lambda[floor(s * disc + t)] / lambdaMax) {
      return(t) # in seconds
    }
  }
}

lambda <- getIntensityFunctionOfThePoissonProcess() # please see the grafic
# time to the next customer at 10 o'clock - lowes chances
t <- simulareTs(12, lambda) # in seconds
floor(t / 0.6) / 100 # in minutes
# time to the next customer at 18 o'clock - bigger chances
t <- simulareTs(18, lambda) # in seconds
floor(t / 0.6) / 100 # in minutes

# ----------------------- Start algorithm ----------------------------
NumberOfTest = 100
for(testNo in 1:NumberOfTest){
  currentTime <- startTime
  t_arrivals <- currentTime + simulareTs(currentTime, lambda) / 3600 # is in hours
  t_departures <- Inf # is in hours
  N_arrivals <- 0
  N_departures <- 0
  NumberPeopleInQueue <- 0
  ArrivalsLogs = c()
  DeparturesLogs = c()
  ExtraTime = 0
  TimeSpentInTheSystem = 0
  
  while(TRUE){
    #a client arrives during the program
    if(t_arrivals <= t_departures && t_arrivals < endTime){
      currentTime <- t_arrivals
      N_arrivals <- N_arrivals + 1
      NumberPeopleInQueue <- NumberPeopleInQueue + 1
      t_arrivals <- currentTime + simulareTs(currentTime, lambda) / 3600
      if(NumberPeopleInQueue == 1){
        currentServingTime <- getServingTime() / 3600
        t_departures <- currentTime + currentServingTime
      }
      ArrivalsLogs = c(ArrivalsLogs, currentTime)
    }
    
    #a client left before another arrives in the working schedule
    if(t_departures <= t_arrivals && t_departures < endTime){
      currentTime <- t_departures
      NumberPeopleInQueue <- NumberPeopleInQueue - 1
      N_departures <- N_departures + 1
      if(NumberPeopleInQueue == 0){
        t_departures <- Inf
      } else {
        currentServingTime <- getServingTime() / 3600
        t_departures <- currentTime + currentServingTime
      }
      DeparturesLogs = c(DeparturesLogs, currentTime)
    }
    
    #a client left after closing and the tail is not to be seen
    if(min(t_arrivals, t_departures) >= endTime && NumberPeopleInQueue > 0){
      currentTime <- t_departures
      NumberPeopleInQueue <- NumberPeopleInQueue - 1
      N_departures <- N_departures + 1
      if(NumberPeopleInQueue > 0){
        currentServingTime <- getServingTime() / 3600
        t_departures <- currentTime + currentServingTime
      }
      DeparturesLogs = c(DeparturesLogs, currentTime)
    }
    
    #the last customer left
    if(min(t_arrivals, t_departures) >= endTime && NumberPeopleInQueue == 0){
      ExtraTime = max(0, currentTime - endTime) * 3600
      break
    }
  }
  
  ExtraTime <- floor(ExtraTime / 0.6) / 100 # minutes
  ExtraTimeLogs = c(ExtraTimeLogs, ExtraTime)
  TimeSpentInTheSystem = floor(mean(DeparturesLogs - ArrivalsLogs) * 3600 / 0.6) / 100
  TimeSpentInTheSystemLogs = c(TimeSpentInTheSystemLogs, TimeSpentInTheSystem)
  print(ArrivalsLogs)
  print(DeparturesLogs)
  print(paste("The last arrival is at the hour = ", ArrivalsLogs[N_arrivals]))
  print(paste("The last departure is at the hour = ", DeparturesLogs[N_arrivals]))
  print(paste("Extra time = ", ExtraTime, " minutes"))
  print(paste("The average time spent in the system = ", TimeSpentInTheSystem, " minutes"))
}

print(paste("Extra time mean = ", mean(ExtraTimeLogs), " minutes"))
print(paste("The average time spent in the system = ", mean(TimeSpentInTheSystemLogs), " minutes"))



