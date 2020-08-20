# Making BoxPlot of the results about 46 leaves samples in figure 11 
library(reshape2)
library(ggplot2)
library(readr)
setwd("C:/Users/49688/Documents/simulation/pycharm/Janes")
Names <- c("Cospeciation","Duplication","Switch","Sorting","Groups")
eventName = c("Events","Differences", "Conditions")
mName <- c("Conditions","Events","Differences")
List <- data.frame()
#DJ46H
DJ46H = read.csv("DJ46H.txt",header = TRUE, sep =" ")
DJ46H <-melt(DJ46H)
DJ46H <- cbind(DJ46H, rep("DJ"))
names(DJ46H) <- eventName 
List <- DJ46H

#DE46H
setwd("C:/Users/49688/Documents/simulation/pycharm/Eucalypt")

lines = read_lines("DE46H.txt", skip = 1)
lines
DE46H = data.frame(matrix(ncol = 4, nrow = 60))
n = 1
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    DE46H[n,1] <- as.numeric(line[1])
    DE46H[n,2] <- as.numeric(line[2])
    DE46H[n,3] <- as.numeric(line[3])
    DE46H[n,4] <- as.numeric(line[4])
    n = n + 1
  }
}
DE46H <- cbind(DE46H[1:n-1,], rep("DE"))
names(DE46H) <- Names
DE46H <- melt(DE46H)
names(DE46H) <- mName
List <- rbind(List,DE46H)


setwd("C:/Users/49688/Documents/simulation/pycharm/CoRe")
#DC46H
lines = read_lines("DC46H.txt", skip = 1)
lines
DC46H = data.frame(matrix(ncol = 4, nrow = 100))
n = 1
for (line in lines)
{
  line = strsplit(line, "\\s+")[[1]]
  if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
  {
    DC46H[n,1] <- as.numeric(line[1])
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
  }
}
DC46H <- cbind(DC46H[1:n-1,], rep("DC"))
DC46H
names(DC46H) <- Names
DC46H <- DC46H[c(1,4,5)]
DC46H <- melt(DC46H)
DC46H
names(DC46H) <- c("Conditions","Events","Differences")
DC46H
List <- rbind(List,DC46H)

#SC46H
lines = read_lines("SC46H.txt", skip = 1)
lines
SC46H = data.frame(matrix(ncol = 4, nrow = 100))
n = 1
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
  }
}
SC46H <- cbind(SC46H[1:n-1,], rep("SC"))
SC46H
names(SC46H) <- Names
SC46H <- SC46H[c(1,5)]
SC46H <- melt(SC46H)
SC46H
names(SC46H) <- c("Conditions","Events","Differences")
SC46H
List <- rbind(List,SC46H)

#TreeCollapse46H
setwd("C:/Users/49688/Documents/simulation/pycharm/TreeCollapse")
DTC46H = read.csv("DTC46H.txt",header = TRUE, sep =" ")
DTC46H <-melt(DTC46H)
DTC46H <- cbind(DTC46H, rep("TC"))
names(DTC46H) <- eventName 
List <- rbind(List, DTC46H)


#BoxPlot

#Boxplot
p <- ggplot(List, aes(x = Events, y = Differences, fill = Events)) + geom_boxplot(show.legend = FALSE)
p <- p + geom_point(aes(fill = Events), size = 1, shape = 21, position = position_jitterdodge(),show.legend = FALSE) 
p  + facet_grid(. ~ Conditions)
