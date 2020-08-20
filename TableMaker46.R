# For the table of results about leaves 46 samples
library(reshape2)
library(ggplot2)
library(readr)

# empty dataframe 
table <- data.frame(matrix(ncol = 16, nrow = 5))
rownames(table) <- c("DJ46", "DE46", "DC46","SC46","TC46")
#OUtOfTime is the number of solution search spending overtime by a tool, 
#D is the difference, the latter C,D,H,S respectively represent cospecaition, duplication, host switching, and sorting
colnames(table) <- c("NumOfSuccesses","OutOfTime","MedianOfTimeWithS", "MedianOfTimeWithoutS","MedianOfDifference","MedianDC","MedianDD","MedianDH"
                     , "MedianDS","AverageOfTimeWithS", "AverageOfTimeWithoutS","MeanOfDifference","AverageDC","AverageDD","AverageDH","AverageDS")
View(table)
#The function to add element into table 
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

#Time 46 tips
List <- data.frame()
# To unify the columns' names
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
#add values about time to dataframe
table["DJ46","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["DJ46","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["DJ46","AverageOfTimeWithS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["DJ46","MedianOfTimeWithS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["DJ46","OutOfTime"] <- 0

# DE46  
setwd("C:/Users/49688/Documents/simulation/DE46")
lines = readLines("Janetime")
fLines <- readLines("C:/Users/49688/Documents/simulation/pycharm/Eucalypt/DE46H.txt")
i <- 1
n <- 1
total <- 1
outTime<- 0
num <- data.frame(matrix(ncol = 1, nrow = 60))
numS <- data.frame(matrix(ncol = 1, nrow = 60))
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
table["DE46","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["DE46","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["DE46","AverageOfTimeWithS"] <- format(round(mean(numS[1:i-1,1]), 2), nsmall = 2)
table["DE46","MedianOfTimeWithS"] <- format(round(median(numS[1:i-1,1]), 2), nsmall = 2)


# DC46 
setwd("C:/Users/49688/Documents/simulation/DC46")
path <- "C:/Users/49688/Documents/simulation/DC46/"
lines = readLines("Janetime")
i <- 1
n <- 1
total <- 1
num <- data.frame(matrix(ncol = 1, nrow = 60))
numS <- data.frame(matrix(ncol = 1, nrow = 60))
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
  total = total + 1
}
table["DC46","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["DC46","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["DC46","AverageOfTimeWithS"] <- format(round(mean(numS[1:i-1,1]), 2), nsmall = 2)
table["DC46","MedianOfTimeWithS"] <- format(round(median(numS[1:i-1,1]), 2), nsmall = 2)

# SC46
setwd("C:/Users/49688/Documents/simulation/SC46")
path <- "C:/Users/49688/Documents/simulation/SC46/"
lines = readLines("Janetime")
i <- 1
n <- 1
total <- 1
times <- 0
num <- data.frame(matrix(ncol = 1, nrow = 60))
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
  total = total + 1
  
}
table["SC46","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["SC46","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["SC46","AverageOfTimeWithS"] <- format(round(mean(numS[1:i-1,1]), 2), nsmall = 2)
table["SC46","MedianOfTimeWithS"] <- format(round(median(numS[1:i-1,1]), 2), nsmall = 2)

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
table["TC46","AverageOfTimeWithoutS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["TC46","MedianOfTimeWithoutS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["TC46","AverageOfTimeWithS"] <- format(round(mean(num[1:n-1,1]), 2), nsmall = 2)
table["TC46","MedianOfTimeWithS"] <- format(round(median(num[1:n-1,1]), 2), nsmall = 2)
table["TC46","OutOfTime"] <- total - n

#
#
#
#46non-TimePercentageDiffernce
setwd("C:/Users/49688/Documents/simulation/pycharm/Janes")
Names <- c("Cospeciation","Duplication","Switch","Sorting")
mName <- c("Conditions","Events","Differences")
List <- data.frame()

#add elements to DJ46H
DJ46H = read.csv("DJ46H.txt",header = TRUE, sep =" ")
table["DJ46","MedianDC"] <- format(round(median(DJ46H[,1]), 2), nsmall = 2)
table["DJ46","MedianDD"] <- format(round(median(DJ46H[,2]), 2), nsmall = 2)
table["DJ46","MedianDH"] <- format(round(median(DJ46H[,3]), 2), nsmall = 2)
table["DJ46","MedianDS"] <- format(round(median(DJ46H[,4]), 2), nsmall = 2)
table["DJ46","AverageDC"] <- format(round(mean(DJ46H[,1]), 2), nsmall = 2)
table["DJ46","AverageDD"] <- format(round(mean(DJ46H[,2]), 2), nsmall = 2)
table["DJ46","AverageDH"] <- format(round(mean(DJ46H[,3]), 2), nsmall = 2)
table["DJ46","AverageDS"] <- format(round(mean(DJ46H[,4]), 2), nsmall = 2)
table["DJ46","NumOfSuccesses"] <- 60


 


#DE46H
setwd("C:/Users/49688/Documents/simulation/pycharm/Eucalypt")
lines = read_lines("DE46H.txt", skip = 1)
DE46H = data.frame(matrix(ncol = 4, nrow = 60))
n = 1
total = 1
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  #Check if the line contains 'solution' or 'time', which represnet fail to find solutions
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    DE46H[n,1] <- as.numeric(line[1])
    DE46H[n,2] <- as.numeric(line[2])
    DE46H[n,3] <- as.numeric(line[3])
    DE46H[n,4] <- as.numeric(line[4])
    
    n = n + 1
  }
  # the number of out of time 
  if (grepl("Time",line) == TRUE){
    times = times + 1
  }
}
DE46H[1:n-1,1]
#Run the function to add the corresponding elements
table <- fillTable("DE46",DE46H[1:n-1, 1], DE46H[1:n-1, 2], DE46H[1:n-1, 3], DE46H[1:n-1, 4],n - 1, table)
#add out of time
table["DE46","OutOfTime"] <- times

#DC46H
setwd("C:/Users/49688/Documents/simulation/pycharm/CoRe")

lines = read_lines("DC46H.txt", skip = 1)
lines
DC46H = data.frame(matrix(ncol = 4, nrow = 60))
n = 1
times <- 0
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    DC46H[n,1] <- as.numeric(line[1])
    #Check if '?', '?' will be not recorded
    if(line[2] != '?')
    {
      DC46H[n,2] <- as.numeric(line[2])
    }
    if(line[3] != '?')
    {
      DC46H[n,3] <- as.numeric(line[3])
    }
    if(line[4] != '?')
    {
      DC46H[n,4] <- as.numeric(line[4])
    }
    n = n + 1
    if (grepl("Time",line) == TRUE){
      times = times + 1
    }
  }
}
table <- fillTable("DC46",DC46H[1:n-1, 1], DC46H[1:n-1, 2], DC46H[1:n-1, 3], DC46H[1:n-1, 4],n - 1, table)
table["DC46","OutOfTime"] <- times

#SC46H
lines = read_lines("SC46H.txt", skip = 1)
lines
SC46H = data.frame(matrix(ncol = 4, nrow = 60))
n = 1
times <- 0
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    SC46H[n,1] <- as.numeric(line[1])
    if(line[2] != '?')
    {
      SC46H[n,2] <- as.numeric(line[2])
    }
    if(line[3] != '?')
    {
      SC46H[n,3] <- as.numeric(line[3])
    }
    if(line[4] != '?')
    {
      SC46H[n,4] <- as.numeric(line[4])
    }
    n = n + 1
    if (grepl("Time",line) == TRUE){
      times = times + 1
    }
  }
}
table <- fillTable("SC46",SC46H[1:n-1, 1], SC46H[1:n-1, 2], SC46H[1:n-1, 3], SC46H[1:n-1, 4],n - 1, table)
table["SC46","OutOfTime"] <- times

#TreeCollapse46H
setwd("C:/Users/49688/Documents/simulation/pycharm/TreeCollapse")
TC46H = read.csv("DTC46H.txt",header = TRUE, sep =" ")
table <- fillTable("TC46",TC46H[1:n-1, 1], TC46H[1:n-1, 2], TC46H[1:n-1, 3], TC46H[1:n-1, 4],60, table)

#
#
#Store the dataframe to csv file
write.csv(table,"C:/Users/49688/Documents/simulation/pycharm/table46.csv", row.names = TRUE)

