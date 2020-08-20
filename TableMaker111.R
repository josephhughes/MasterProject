#Making table for the results from tools about 111 leaves Retroviridae simulations
# The annotations refer to TableMaker46.R
library(reshape2)
library(ggplot2)
library(readr)

table <- data.frame(matrix(ncol = 16, nrow = 5))
rownames(table) <- c("DJ111", "DE111", "DC111","SC111","TC111")
colnames(table) <- c("NumOfSuccesses","OutOfTime","MedianOfTimeWithS","MedianOfTimeWithoutS","MedianOfDifference","MedianDC","MedianDD","MedianDH"
                     , "MedianDS","AverageOfTimeWithS","AverageOfTimeWithoutS","MeanOfDifference","AverageDC","AverageDD","AverageDH","AverageDS")
View(table)
fillTable <- function(nameRow, dc,dd,dh,ds,num, table) {
  table[nameRow,"MedianDC"] <- format(round(median(dc), 2), nsmall = 2)
  table[nameRow,"MedianDD"] <- format(round(median(dd), 2), nsmall = 2)
  table[nameRow,"MedianDH"] <- format(round(median(dh), 2), nsmall = 2)
  table[nameRow,"MedianDS"] <- format(round(median(ds), 2), nsmall = 2)
  table[nameRow,"AverageDC"] <- format(round(mean(dc), 2), nsmall = 2)
  table[nameRow,"AverageDD"] <- format(round(mean(dd), 2), nsmall = 2)
  table[nameRow,"AverageDH"] <- format(round(mean(dh), 2), nsmall = 2)
  table[nameRow,"AverageDS"] <- format(round(mean(ds), 2), nsmall = 2)
  table[nameRow,"NumOfSuccesses"] <- num
  return(table)
}

#Time 111 tips
name <- c("Time", "Order", "Conditions")
# DJ111 SJ111
setwd("C:/Users/49688/Documents/simulation/DJanes111R")
lines = readLines("Janetime")
n <- 1
num <- data.frame(matrix(ncol = 2, nrow = 40))
for (line in lines)
{
  num[n, 1] <- as.numeric(strsplit(line, "\\n+")[[1]][1])
  num[n,2] <- n
  n = n + 1
}
table["DJ111","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["DJ111","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["DJ111","AverageOfTimeWithS"] <- format(round(mean(num[1:i-1,1]), 2), nsmall = 2)
table["DJ111","MedianOfTimeWithS"] <- format(round(median(num[1:i-1,1]), 2), nsmall = 2)
table["DJ111","OutOfTime"] <- 0
num

# DE111 
setwd("C:/Users/49688/Documents/simulation/DEucalypt111R")
lines = readLines("Janetime")
fLines <- readLines("C:/Users/49688/Documents/simulation/pycharm/Eucalypt/DE111R.txt")
i <- 1
n <- 1
total <- 1
outTime<- 0
num <- data.frame(matrix(ncol = 1, nrow = 40))
numS <- data.frame(matrix(ncol = 1, nrow = 40))
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
      if( grepl("Solution", fLines[i]) != TRUE){
        numS[i, 1] <- length
        numS[i,2] <- total
        i = i + 1
      }
      num[n, 1] <- length
      num[n,2] <- total
      n = n + 1
    }
  }
  total = total + 1
}

table["DE111","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["DE111","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["DE111","AverageOfTimeWithS"] <- format(round(mean(numS[1:i-1,1]), 2), nsmall = 2)
table["DE111","MedianOfTimeWithS"] <- format(round(median(numS[1:i-1,1]), 2), nsmall = 2)


# DC111 
setwd("C:/Users/49688/Documents/simulation/DCoRe111R")
path <- "C:/Users/49688/Documents/simulation/DCoRe111R/"
lines = readLines("Janetime")
i <- 1
n <- 1
total <- 1
num <- data.frame(matrix(ncol = 1, nrow = 40))
numS <- data.frame(matrix(ncol = 1, nrow = 40))
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
      #Two cases, one remove the solutions check to get boxplots contain no solution results
      #and one add the check to add information about the results which have solutions 
      #Solution check by checking if there is output file but not only a file names 'sample*'
      file <- paste0(path,"output", as.character(total - 1))
      if (file.exists(file) == TRUE)
      {
        numS[i, 1] <- length
        numS[i,2] <- total
        i = i + 1
      }
    }
  }
  total = total + 1
}
table["DC111","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["DC111","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["DC111","AverageOfTimeWithS"] <- format(round(mean(numS[1:i-1,1]), 2), nsmall = 2)
table["DC111","MedianOfTimeWithS"] <- format(round(median(numS[1:i-1,1]), 2), nsmall = 2)


# SC111
setwd("C:/Users/49688/Documents/simulation/SCoRe111R")
path <- "C:/Users/49688/Documents/simulation/SCoRe111R/"
lines = readLines("Janetime")
i <- 1
n <- 1
total <- 1
num <- data.frame(matrix(ncol = 1, nrow = 40))
numS <- data.frame(matrix(ncol = 1, nrow = 40))
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
      #Two cases, one remove the solutions check to get boxplots contain no solution results
      #and one add the check to add information about the results which have solutions 
      #Solution check by checking if there is output file but not only a file names 'sample*'
      file <- paste0(path,"output", as.character(total - 1))
      if (file.exists(file) == TRUE)
      {
        numS[i, 1] <- length
        numS[i,2] <- total
        i = i + 1
      }
    }
  }
  total = total + 1
}
table["SC111","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["SC111","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["SC111","AverageOfTimeWithS"] <- format(round(mean(num[1:i-1,1]), 2), nsmall = 2)
table["SC111","MedianOfTimeWithS"] <- format(round(median(num[1:i-1,1]), 2), nsmall = 2)


# DTC111
setwd("C:/Users/49688/Documents/simulation/DTC111R")
lines = readLines("Janetime")
n <- 1
total <- 1
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
table["TC111","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["TC111","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["TC111","AverageOfTimeWithS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["TC111","MedianOfTimeWithS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["TC111","OutOfTime"] <- total - n

fillTable <- function(nameRow, dc,dd,dh,ds,num, table) {
  table[nameRow,"MedianDC"] <- format(round(median(dc), 2), nsmall = 2)
  table[nameRow,"MedianDD"] <- format(round(median(dd), 2), nsmall = 2)
  table[nameRow,"MedianDH"] <- format(round(median(dh), 2), nsmall = 2)
  table[nameRow,"MedianDS"] <- format(round(median(ds), 2), nsmall = 2)
  table[nameRow,"AverageDC"] <- format(round(mean(dc), 2), nsmall = 2)
  table[nameRow,"AverageDD"] <- format(round(mean(dd), 2), nsmall = 2)
  table[nameRow,"AverageDH"] <- format(round(mean(dh), 2), nsmall = 2)
  table[nameRow,"AverageDS"] <- format(round(mean(ds), 2), nsmall = 2)
  table[nameRow,"NumOfSuccesses"] <- num
  return(table)
}

#111non-TimePercentageDiffernce
setwd("C:/Users/49688/Documents/simulation/pycharm/Janes")
Names <- c("Cospeciation","Duplication","Switch","Sorting")
mName <- c("Conditions","Events","Differences")
List <- data.frame()
#DJ111RP
DJ111R = read.csv("DJ111R.txt",header = TRUE, sep =" ")
table["DJ111","MedianDC"] <- format(round(median(DJ111R[,1]), 2), nsmall = 2)
table["DJ111","MedianDD"] <- format(round(median(DJ111R[,2]), 2), nsmall = 2)
table["DJ111","MedianDH"] <- format(round(median(DJ111R[,3]), 2), nsmall = 2)
table["DJ111","MedianDS"] <- format(round(median(DJ111R[,4]), 2), nsmall = 2)
table["DJ111","AverageDC"] <- format(round(mean(DJ111R[,1]), 2), nsmall = 2)
table["DJ111","AverageDD"] <- format(round(mean(DJ111R[,2]), 2), nsmall = 2)
table["DJ111","AverageDH"] <- format(round(mean(DJ111R[,3]), 2), nsmall = 2)
table["DJ111","AverageDS"] <- format(round(mean(DJ111R[,4]), 2), nsmall = 2)
table["DJ111","NumOfSuccesses"] <- 40


#SJ111R
# SJ111R = read.csv("SJ111R.txt",header = TRUE, sep =" ")
# table["SJ111","MedianDC"] <- format(round(median(SJ111R[,1]), 2), nsmall = 2)
# table["SJ111","MedianDD"] <- format(round(median(SJ111R[,2]), 2), nsmall = 2)
# table["SJ111","MedianDH"] <- format(round(median(SJ111R[,3]), 2), nsmall = 2)
# table["SJ111","MedianDS"] <- format(round(median(SJ111R[,4]), 2), nsmall = 2)
# table["SJ111","AverageDC"] <- format(round(mean(SJ111R[,1]), 2), nsmall = 2)
# table["SJ111","AverageDD"] <- format(round(mean(SJ111R[,2]), 2), nsmall = 2)
# table["SJ111","AverageDH"] <- format(round(mean(SJ111R[,3]), 2), nsmall = 2)
# table["SJ111","AverageDS"] <- format(round(mean(SJ111R[,4]), 2), nsmall = 2)
# table["SJ111","NumOfSuccesses"] <- 40



#DE111R
setwd("C:/Users/49688/Documents/simulation/pycharm/Eucalypt")
lines = read_lines("DE111R.txt", skip = 1)
DE111R = data.frame(matrix(ncol = 4, nrow = 40))
n = 1
total = 1
times <- 0
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    DE111R[n,1] <- as.numeric(line[1])
    DE111R[n,2] <- as.numeric(line[2])
    DE111R[n,3] <- as.numeric(line[3])
    DE111R[n,4] <- as.numeric(line[4])
    
    n = n + 1
  }
  if (grepl("Time",line) == TRUE){
    times = times + 1
  }
}
times
table <- fillTable("DE111",DE111R[1:n-1, 1], DE111R[1:n-1, 2], DE111R[1:n-1, 3], DE111R[1:n-1, 4],n - 1, table)
table["DE111","OutOfTime"] <- times

setwd("C:/Users/49688/Documents/simulation/pycharm/CoRe")
#DC111R
lines = read_lines("DC111R.txt", skip = 1)
lines
times <- 0 
DC111R = data.frame(matrix(ncol = 4, nrow = 40))
n = 1
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    #Get the number of events for statistics
    DC111R[n,1] <- as.numeric(line[1])
    if(line[2] != '?')
    {
      DC111R[n,2] <- as.numeric(line[2])
    }
    if(line[3] != '?')
    {
      DC111R[n,3] <- as.numeric(line[3])
    }
    if(line[4] != '?')
    {
      DC111R[n,4] <- as.numeric(line[4])
    }
    n = n + 1
    if (grepl("Time",line) == TRUE){
      times = times + 1
    }
  }
}
table <- fillTable("DC111",DC111R[1:n-1, 1], DC111R[1:n-1, 2], DC111R[1:n-1, 3], DC111R[1:n-1, 4],n - 1, table)
table["DC111","OutOfTime"] <- times

#SC111R
lines = read_lines("SC111R.txt", skip = 1)
lines
SC111R = data.frame(matrix(ncol = 4, nrow = 40))
times <- 0
n = 1
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    SC111R[n,1] <- as.numeric(line[1])
    if(line[2] != '?')
    {
      SC111R[n,2] <- as.numeric(line[2])
    }
    if(line[3] != '?')
    {
      SC111R[n,3] <- as.numeric(line[3])
    }
    if(line[4] != '?')
    {
      SC111R[n,4] <- as.numeric(line[4])
    }
    n = n + 1
  }
  if (grepl("Time",line) == TRUE){
    times = times + 1
  }
}
table <- fillTable("SC111",SC111R[1:n-1, 1], SC111R[1:n-1, 2], SC111R[1:n-1, 3], SC111R[1:n-1, 4],n - 1, table)
table["SC111","OutOfTime"] <- times


#TreeCollapse111R
setwd("C:/Users/49688/Documents/simulation/pycharm/TreeCollapse")
TC111R = read.csv("DTC111R.txt",header = TRUE, sep =" ")
table <- fillTable("TC111",TC111R[1:n-1, 1], TC111R[1:n-1, 2], TC111R[1:n-1, 3], TC111R[1:n-1, 4],40, table)
write.csv(table,"C:/Users/49688/Documents/simulation/pycharm/table111.csv", row.names = TRUE)
