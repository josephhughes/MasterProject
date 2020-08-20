#Making table for the results from tools about 100 leaves sample
# The annotations refer to TableMaker46.R
library(reshape2)
library(ggplot2)
library(readr)

table <- data.frame(matrix(ncol = 16, nrow = 5))
rownames(table) <- c("DJ100","DE100", "DC100", "SC100","TC100")
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

#Time 100 tips
name <- c("Time", "Order", "Conditions")
# DJ100 SJ100
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
table["DJ100","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["DJ100","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["DJ100","AverageOfTimeWithS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["DJ100","MedianOfTimeWithS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["DJ100","OutOfTime"] <- 0
num

 # DE100 
setwd("C:/Users/49688/Documents/simulation/DEucalypt100H")
lines = readLines("Janetime")
fLines <- readLines("C:/Users/49688/Documents/simulation/pycharm/Eucalypt/DE100H.txt")
i <- 1
n <- 1
total <- 1
outTime<- 0
num <- data.frame(matrix(ncol = 1, nrow = 40))
for (line in lines)
{
  s <- strsplit(line, "\\n+")[[1]][1]
  if(grepl("OutOfTime",s) != TRUE)
  {
    length <- as.numeric(s)
    if (length < 5400)
    {
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
table["DE100","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["DE100","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["DE100","AverageOfTimeWithS"] <- format(round(mean(numS[1:i-1,1]), 2), nsmall = 2)
table["DE100","MedianOfTimeWithS"] <- format(round(median(numS[1:i-1,1]), 2), nsmall = 2)
table["DE100","OutOfTime"] <- total - n


# DC100 
setwd("C:/Users/49688/Documents/simulation/DCoRe100H")
path <- "C:/Users/49688/Documents/simulation/DCoRe100H/"
lines = readLines("Janetime")
n <- 1
i <- 1
total <- 1
times <- 0
num <- data.frame(matrix(ncol = 1, nrow = 40))
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
      file <- paste0(path,"output", as.character(total - 1))
      if (file.exists(file) == TRUE)
      {
        numS[i, 1] <- length
        numS[i,2] <- total
        i = i + 1
      }
    }
  }
  if (length > 5400){
    times = times + 1
  }
  total = total + 1
}
table["DC100","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["DC100","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["DC100","AverageOfTimeWithS"] <- format(round(mean(numS[1:i-1,1]), 2), nsmall = 2)
table["DC100","MedianOfTimeWithS"] <- format(round(median(numS[1:i-1,1]), 2), nsmall = 2)
table["DC100","OutOfTime"] <- times

# SC100
setwd("C:/Users/49688/Documents/simulation/SCoRe100H")
path <- "C:/Users/49688/Documents/simulation/SCoRe100H/"
lines = readLines("Janetime")
i <- 1
n <- 1
total <- 1
times <- 0
num <- data.frame(matrix(ncol = 1, nrow = 40))
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
      file <- paste0(path,"output", as.character(total - 1))
      if (file.exists(file) == TRUE)
      {
        numS[i, 1] <- length
        numS[i,2] <- total
        i = i + 1
      }
    }
  }
  if (length > 5400){
    times = times + 1
  }
  total = total + 1
}
total
table["SC100","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["SC100","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["SC100","AverageOfTimeWithS"] <- format(round(mean(numS[1:i-1,1]), 2), nsmall = 2)
table["SC100","MedianOfTimeWithS"] <- format(round(median(numS[1:i-1,1]), 2), nsmall = 2)
table["SC100","OutOfTime"] <- times

# DTC100
setwd("C:/Users/49688/Documents/simulation/DTC100H")
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
table["TC100","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["TC100","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["TC100","AverageOfTimeWithS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["TC100","MedianOfTimeWithS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["TC100","OutOfTime"] <- total - n

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

#100non-TimePercentageDiffernce
setwd("C:/Users/49688/Documents/simulation/pycharm/Janes")
Names <- c("Cospeciation","Duplication","Switch","Sorting")
mName <- c("Conditions","Events","Differences")
List <- data.frame()
#DJ100HP
DJ100H = read.csv("DJ100H.txt",header = TRUE, sep =" ")
table["DJ100","MedianDC"] <- format(round(median(DJ100H[,1]), 2), nsmall = 2)
table["DJ100","MedianDD"] <- format(round(median(DJ100H[,2]), 2), nsmall = 2)
table["DJ100","MedianDH"] <- format(round(median(DJ100H[,3]), 2), nsmall = 2)
table["DJ100","MedianDS"] <- format(round(median(DJ100H[,4]), 2), nsmall = 2)
table["DJ100","AverageDC"] <- format(round(mean(DJ100H[,1]), 2), nsmall = 2)
table["DJ100","AverageDD"] <- format(round(mean(DJ100H[,2]), 2), nsmall = 2)
table["DJ100","AverageDH"] <- format(round(mean(DJ100H[,3]), 2), nsmall = 2)
table["DJ100","AverageDS"] <- format(round(mean(DJ100H[,4]), 2), nsmall = 2)
table["DJ100","NumOfSuccesses"] <- 40


#DE100H
setwd("C:/Users/49688/Documents/simulation/pycharm/Eucalypt")
lines = read_lines("DE100H.txt", skip = 1)
DE100H = data.frame(matrix(ncol = 4, nrow = 40))
n = 1
total = 1
times = 0
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    DE100H[n,1] <- as.numeric(line[1])
    DE100H[n,2] <- as.numeric(line[2])
    DE100H[n,3] <- as.numeric(line[3])
    DE100H[n,4] <- as.numeric(line[4])
    
    n = n + 1
  }
  if (grepl("Time",line) == TRUE){
    times = times + 1
  }
}

table <- fillTable("DE100",DE100H[1:n-1, 1], DE100H[1:n-1, 2], DE100H[1:n-1, 3], DE100H[1:n-1, 4],n - 1, table)
table["DE100","OutOfTime"] <- times


setwd("C:/Users/49688/Documents/simulation/pycharm/CoRe")
#DC100H
lines = read_lines("DC100H.txt", skip = 1)
lines
DC100H = data.frame(matrix(ncol = 4, nrow = 100))
n = 1
times <- 0
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    DC100H[n,1] <- as.numeric(line[1])
    if(line[2] != '?')
    {
      DC100H[n,2] <- as.numeric(line[2])
    }
    if(line[3] != '?')
    {
      DC100H[n,3] <- as.numeric(line[3])
    }
    if(line[4] != '?')
    {
      DC100H[n,4] <- as.numeric(line[4])
    }
    n = n + 1
  }
  if (grepl("Time",line) == TRUE){
    times = times + 1
  }
}
n
times
table <- fillTable("DC100",DC100H[1:n-1, 1], DC100H[1:n-1, 2], DC100H[1:n-1, 3], DC100H[1:n-1, 4],n - 1, table)
table["DC100","OutOfTime"] <- times

#SC100H
lines = read_lines("SC100H.txt", skip = 1)
lines
SC100H = data.frame(matrix(ncol = 4, nrow = 100))
n = 1
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    SC100H[n,1] <- as.numeric(line[1])
    if(line[2] != '?')
    {
      SC100H[n,2] <- as.numeric(line[2])
    }
    if(line[3] != '?')
    {
      SC100H[n,3] <- as.numeric(line[3])
    }
    if(line[4] != '?')
    {
      SC100H[n,4] <- as.numeric(line[4])
    }
    n = n + 1
    if (grepl("Time",line) == TRUE){
      times = times + 1
    }
  }
}
table <- fillTable("SC100",SC100H[1:n-1, 1], SC100H[1:n-1, 2], SC100H[1:n-1, 3], SC100H[1:n-1, 4],n - 1, table)
table["SC100","OutOfTime"] <- times

#TreeCollapse100H
setwd("C:/Users/49688/Documents/simulation/pycharm/TreeCollapse")
TC100H = read.csv("DTC100H.txt",header = TRUE, sep =" ")
table <- fillTable("TC100",TC100H[1:n-1, 1], TC100H[1:n-1, 2], TC100H[1:n-1, 3], TC100H[1:n-1, 4],40, table)
write.csv(table,"C:/Users/49688/Documents/simulation/pycharm/table100.csv", row.names = TRUE)
