# Making BoxPlot  of the results about 100 leaves samples in figure 11 
library(ggplot2)
library(reshape2)
library(readr)


Names <- c("Cospeciation","Duplication","Switch","Sorting","Groups")
mName <- c("Conditions","Events","Differences")
List <- data.frame()

setwd("C:/Users/49688/Documents/simulation/pycharm/Janes")
#DJ100H
lines = read_lines("DJ100H.txt", skip = 1)
lines
DJ100H = data.frame(matrix(ncol = 4, nrow = 40))
n = 1
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    DJ100H[n,1] <- as.numeric(line[1])
    DJ100H[n,2] <- as.numeric(line[2])
    DJ100H[n,3] <- as.numeric(line[3])
    DJ100H[n,4] <- as.numeric(line[4])
    n = n + 1
  }
}
DJ100H <- cbind(DJ100H[1:n-1,], rep("DJ"))
names(DJ100H) <- Names
DJ100H <- melt(DJ100H)
names(DJ100H) <- mName
List <- DJ100H
List

#DE100H
lines = read_lines("DE100H.txt", skip = 1)
lines
DE100H = data.frame(matrix(ncol = 4, nrow = 40))
n = 1
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
}
DE100H <- cbind(DE100H[1:n-1,], rep("DE"))
names(DE100H) <- Names
DE100H <- melt(DE100H)
names(DE100H) <- mName
List <- rbind(List,DE100H)



setwd("C:/Users/49688/Documents/simulation/pycharm/CoRe")
#DC100H
lines = read_lines("DC100H.txt", skip = 1)
lines
DC100H = data.frame(matrix(ncol = 4, nrow = 40))
n = 1
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
}
DC100H
DC100H <- cbind(DC100H[1:n-1,], rep("DC"))
names(DC100H) <- Names
DC100H <- melt(DC100H[,c(1,4,5)])
names(DC100H) <- mName
List <- rbind(List,DC100H)

#SC100H
lines = read_lines("SC100H.txt", skip = 1)
lines
SC100H = data.frame(matrix(ncol = 4, nrow = 40))
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
  }
}
SC100H <- cbind(SC100H[1:n-1,], rep("SC"))
names(SC100H) <- Names
SC100H <- SC100H[c(1,5)]
SC100H
SC100H <- melt(SC100H)
names(SC100H) <- mName
SC100H
List <- rbind(List,SC100H)

setwd("C:/Users/49688/Documents/simulation/pycharm/TreeCollapse")
#DTC111R
lines = read_lines("DTC100H.txt", skip = 1)
lines
DTC100H = data.frame(matrix(ncol = 4, nrow = 40))
n = 1
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    DTC100H[n,1] <- as.numeric(line[1])
    DTC100H[n,2] <- as.numeric(line[2])
    DTC100H[n,3] <- as.numeric(line[3])
    DTC100H[n,4] <- as.numeric(line[4])
    n = n + 1
  }
}
DTC100H <- cbind(DTC100H[1:n-1,], rep("TC"))
names(DTC100H) <- Names
DTC100H <- melt(DTC100H)
names(DTC100H) <- mName
List <- rbind(List, DTC100H)
List

#Boxplot
p <- ggplot(List, aes(x = Events, y = Differences, fill = Events)) + geom_boxplot(show.legend = FALSE)
p <- p + geom_point(aes(fill = Events), size = 1, shape = 21, position = position_jitterdodge(),show.legend = FALSE) 
p  + facet_grid(. ~ Conditions)


