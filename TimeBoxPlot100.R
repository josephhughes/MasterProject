#Get boxplots of time for the results about 100 leaves Hepadnaviridae simulations

library(ggplot2)
library(dplyr)
#Time 100 tips
List <- data.frame()
#Unify the columns names
name <- c("Time", "Order", "Conditions")
# DJ100 get Time to dataframe
setwd("C:/Users/49688/Documents/simulation/DJanes100H")
lines = readLines("Janetime")
n <- 1
num <- data.frame(matrix(ncol = 2, nrow = 40))
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

# DE111 get Time to dataframe
setwd("C:/Users/49688/Documents/simulation/DEucalypt100H")

lines = readLines("Janetime")
#filter no solution
fLines <- readLines("C:/Users/49688/Documents/simulation/pycharm/Eucalypt/DE100H.txt")
i <- 1
n <- 1
total <- 0
timeRecorder <- data.frame(matrix(ncol = 2, nrow = 40))
num <- data.frame(matrix(ncol = 2, nrow = 40))
for (line in lines)
{
  s <- strsplit(line, "\\n+")[[1]][1]
  if(grepl("OutOfTime",s) != TRUE)
  {
    length <- as.numeric(s)
    
    if (length <= 5400)
    {
      
      #Two cases, one remove the solutions check to get boxplots contain no solution results
      #and one add the check to add information about the results which have solutions 
      #solutionCheck
      if( grepl("Solution", fLines[i]) != TRUE){
        num[n, 1] <- length
        num[n,2] <- total
        timeRecorder[n, 1] <- length
        timeRecorder[n,2] <- total
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

# The relationship between Solution - time, figure 10 in report
path <- "C:/Users/49688/Documents/simulation/DEucalypt100H/"
timeRecorder <- num
# num of solution
n <- 1
for (i in timeRecorder$Order){
  file <- paste0(path, "sample",i)
  lines <- readLines(file)
  line <- tail(lines, 2)
  line[1]
  numAcyclic <- as.numeric(strsplit(line[1], " ")[[1]][7])
  print(line[1])
  numCyclic <- as.numeric(strsplit(line[2], " ")[[1]][7])
  timeRecorder[n,4] <- numAcyclic + numCyclic
  n = n + 1
} 
names(timeRecorder)[4]<- "100Solution"
timeRecorder


# DC100
setwd("C:/Users/49688/Documents/simulation/DCoRe100H")
path <- "C:/Users/49688/Documents/simulation/DCoRe100H/"
lines = readLines("Janetime")
n <- 1
total <- 0
num <- data.frame(matrix(ncol = 1, nrow = 40))
for (line in lines)
{
  s <- strsplit(line, "\\n+")[[1]][1]
  if(grepl("OutOfTime",s) != TRUE)
  {
    length <- as.numeric(s)
    if (length < 5400)
    {
      file <- paste0(path,"output", as.character(total))
      #Two cases, one remove the solutions check to get boxplots contain no solution results
      #and one add the check to add information about the results which have solutions 
      #Solution check by checking if there is output file but not only a file names 'sample*'
      if (file.exists(file) == TRUE){
      
        num[n, 1] <- length
        num[n,2] <- total
        n = n + 1
        print(n)
      }
    }
  }
  total = total + 1
}
num
num <- cbind(num[1:n-1,], rep("DC"))
names(num) <- name
List <- rbind(List, num)

# SC100
setwd("C:/Users/49688/Documents/simulation/SCoRe100H")
path <- "C:/Users/49688/Documents/simulation/SCoRe100H/"
lines = readLines("Janetime")
n <- 1
total <- 0
num <- data.frame(matrix(ncol = 1, nrow = 40))
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
      #Solution check by checking if there is output file but not only a file names 'sample*'
      file <- paste0(path,"output", as.character(total))
      
      if (file.exists(file) == TRUE){
      
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

# DTC100
setwd("C:/Users/49688/Documents/simulation/DTC100H")
lines = readLines("Janetime")
n <- 1
total <- 0
num <- data.frame(matrix(ncol = 2, nrow = 40))
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
p + geom_point() + labs(x = "", y="Time (s)", title = "The Results with Solutions")

#aNova
#Computes summary of anova by groups
aov <- aov(Time ~ Conditions, List)
summary(aov)
tk <- TukeyHSD(aov)
tk
# Tukey test representation :
plot(tk , las=1 , col="brown")
