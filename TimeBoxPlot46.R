#Get boxplots of time for the results about 46 leaves Hepadnaviridae simulations


library(ggplot2)
library(dplyr)
#Time 46 tips
List <- data.frame()
#Unify the columns names
name <- c("Time", "Order", "Conditions")
# DJ46
setwd("C:/Users/49688/Documents/simulation/DJ46")
lines = readLines("Janetime")
n <- 1
num <- data.frame(matrix(ncol = 2, nrow = 60))
for (line in lines)
{
  num[n, 1] <- as.numeric(strsplit(line, "\\n+")[[1]][1])
  num[n,2] <- n
  n = n + 1
}
num
num <- cbind(num, rep("DJ"))
names(num) <- name
List <- num
List

# DE46 get Time to dataframe
setwd("C:/Users/49688/Documents/simulation/DE46")
lines = readLines("Janetime")
#filter no solution
fLines <- readLines("C:/Users/49688/Documents/simulation/pycharm/Eucalypt/DE46H.txt")
i <- 1
n <- 1
total <- 1
num <- data.frame(matrix(ncol = 1, nrow = 60))
for (line in lines)
{
  s <- strsplit(line, "\\n+")[[1]][1]
  if(grepl("OutOfTime",s) != TRUE)
  {
    length <- as.numeric(s)
    if (length <= 5400)
    {
      #solutionCheck
      if( grepl("Solution", fLines[i]) != TRUE){
        num[n, 1] <- length
        num[n,2] <- total
        n = n + 1
      }
    }
  }
  i = i + 1
  total = total + 1
}
num
num <- cbind(num[1:n-1,], rep("DE"))
names(num) <- name
List <- rbind(List, num)



# DC46 get Time to dataframe
setwd("C:/Users/49688/Documents/simulation/DC46")
path <- "C:/Users/49688/Documents/simulation/DC46/"
lines = readLines("Janetime")
n <- 1
total <- 1
num <- data.frame(matrix(ncol = 1, nrow = 60))
for (line in lines)
{
  s <- strsplit(line, "\\n+")[[1]][1]
  if(grepl("OutOfTime",s) != TRUE)
  {
    length <- as.numeric(s)
    if (length < 5400)
    {
      #Two cases, one remove the solutions check to get boxplots contain no solution results
      #and one add the check to add information about the results which have solutions 
      #solutionCheck
      file <- paste0(path,"output", as.character(total))
      if (file.exists(file) == TRUE)
      {
        num[n, 1] <- length
        num[n,2] <- total
        n = n + 1
        print(n)
      }
    }
  }
  total = total + 1
}
num <- cbind(num[1:n-1,], rep("DC"))
num
names(num) <- name
List <- rbind(List, num)

# SC46 get Time to dataframe
setwd("C:/Users/49688/Documents/simulation/SC46")
path <- "C:/Users/49688/Documents/simulation/SC46/"
lines = readLines("Janetime")
n <- 1
total <- 1
num <- data.frame(matrix(ncol = 1, nrow = 60))
for (line in lines)
{
  s <- strsplit(line, "\\n+")[[1]][1]
  if(grepl("OutOfTime",s) != TRUE)
  {
    length <- as.numeric(s)
    if (length < 5400)
    {
      #Two cases, one remove the solutions check to get boxplots contain no solution results
      #and one add the check to add information about the results which have solutions 
      #solutionCheck
      file <- paste0(path,"output", as.character(total))
      if (file.exists(file) == TRUE)
      {
        num[n, 1] <- length
        num[n,2] <- total
        n = n + 1
        print(n)
      }
    }
  }
  total = total + 1
}
num <- cbind(num[1:n-1,], rep("SC"))
names(num) <- name
List <- rbind(List, num)

# DTC46
setwd("C:/Users/49688/Documents/simulation/DTC46H")
lines = readLines("Janetime")
n <- 1
total <- 1
num <- data.frame(matrix(ncol = 2, nrow = 60))
for (line in lines)
{
  s <- strsplit(line, "\\n+")[[1]][1]
  if(grepl("OutOfTime",s) != TRUE)
  {
    length <- as.numeric(s)
    if (length < 5400)
    {
      num[n, 1] <- length
      num[n,2] <- total
      n = n + 1
      print(n)
    }
  }
  total = total + 1
}
num
num <- cbind(num, rep("TC"))
names(num) <- name
List <- rbind(List, num)
List

#Boxplot
#Two title, with and no solutions
p <- ggplot(List, aes(x = Conditions, y = Time))+ geom_boxplot()
p + geom_point() + labs(x = "", y="Time (s)", title = "The Results Probably No Solutions")

#aNova
#Computes summary of statistics by groups
aov <- aov(Time ~ Conditions, List)
summary(aov)
tk <- TukeyHSD(aov)
tk
# Tukey test representation :
plot(tk , las=1 , col="brown")
