# Making BoxPlot of the results about 111 leaves samples in figure 11 
library(ggplot2)
library(reshape2)
library(readr)
#Unify the column names
Names <- c("Cospeciation","Duplication","Switch","Sorting","Groups")
mName <- c("Conditions","Events","Differences")
List <- data.frame()

setwd("C:/Users/49688/Documents/simulation/pycharm/Janes")
#DJ111R Get the number of each event to dataframe
lines = read_lines("DJ111R.txt", skip = 1)
lines
DJ111R = data.frame(matrix(ncol = 4, nrow = 40))
n = 1
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    DJ111R[n,1] <- as.numeric(line[1])
    DJ111R[n,2] <- as.numeric(line[2])
    DJ111R[n,3] <- as.numeric(line[3])
    DJ111R[n,4] <- as.numeric(line[4])
    n = n + 1
  }
}
DJ111R <- cbind(DJ111R[1:n-1,], rep("DJ"))
names(DJ111R) <- Names
DJ111R <- melt(DJ111R)
names(DJ111R) <- mName
List <- DJ111R
 List


setwd("C:/Users/49688/Documents/simulation/pycharm/Eucalypt")
#DE111R Get the number of each event to dataframe
lines = read_lines("DE111R.txt", skip = 1)
lines
DE111R = data.frame(matrix(ncol = 4, nrow = 40))
n = 1
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
}
DE111R <- cbind(DE111R[1:n-1,], rep("DE"))
names(DE111R) <- Names
DE111R <- melt(DE111R)
names(DE111R) <- mName
List <- rbind(List,DE111R)



setwd("C:/Users/49688/Documents/simulation/pycharm/CoRe")
#DC111R Get the number of each event to dataframe
lines = read_lines("DC111R.txt", skip = 1)
lines
DC111R = data.frame(matrix(ncol = 4, nrow = 40))
n = 1
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
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
  }
}
DC111R <- cbind(DC111R[1:n-1,], rep("DC"))
names(DC111R) <- Names
DC111R <- DC111R[c(1,4,5)]
DC111R
DC111R <- melt(DC111R)
names(DC111R) <- mName
DC111R
List <- rbind(List,DC111R)

#SC111R Get the number of each event to dataframe
lines = read_lines("SC111R.txt", skip = 1)
lines
SC111R = data.frame(matrix(ncol = 4, nrow = 40))
n = 1
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    #only record the number found by CoRe-ILP
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
}
SC111R <- cbind(SC111R[1:n-1,], rep("SC"))
names(SC111R) <- Names
SC111R <- SC111R[c(1,5)]
SC111R
SC111R <- melt(SC111R)
names(SC111R) <- mName
SC111R
List <- rbind(List,SC111R)

setwd("C:/Users/49688/Documents/simulation/pycharm/TreeCollapse")
#DTC111R
lines = read_lines("DTC111R.txt", skip = 1)
lines
DTC111R = data.frame(matrix(ncol = 4, nrow = 40))
n = 1
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    DTC111R[n,1] <- as.numeric(line[1])
    DTC111R[n,2] <- as.numeric(line[2])
    DTC111R[n,3] <- as.numeric(line[3])
    DTC111R[n,4] <- as.numeric(line[4])
    n = n + 1
  }
}
DTC111R <- cbind(DTC111R[1:n-1,], rep("TC"))
names(DTC111R) <- Names
DTC111R <- melt(DTC111R)
names(DTC111R) <- mName
List <- rbind(List, DTC111R)
List
List
#Boxplot
library(dplyr)
p <- ggplot(List, aes(x = Events, y = Differences, fill = Events)) + geom_boxplot(show.legend = FALSE)
p <- p + geom_point(aes(fill = Events), size = 1, shape = 21, position = position_jitterdodge(), show.legend = FALSE) 
p  + facet_grid(. ~ Conditions)
