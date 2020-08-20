# Making the confidence intervals plot of the results about 100 leaves samples in figure 11
# before 140 is similar to boxplotMaker, but here the correct number of each event and the number inferred by tools are collected
library(dplyr)
library(reshape2)
library(ggplot2)
library(readr)

Names <- c("Cospeciation","Duplication","Switch","Sorting","Groups")
eventName = c("Events","Differences", "Conditions")
mName <- c("Conditions","Events","Differences")
#100H answer
setwd("C:/Users/49688/Documents/simulation/pycharm")
r100H = read.csv("r100H.txt",header = TRUE, sep =" ")
r100H <-melt(r100H)
r100H <- cbind(r100H, rep("Ans"))
names(r100H) <- eventName 
List <- r100H

setwd("C:/Users/49688/Documents/simulation/pycharm/Janes")
#DJ100H
DJ100H = read.csv("ODJ100H.txt",header = TRUE, sep =" ")
DJ100H <-melt(DJ100H)
DJ100H <- cbind(DJ100H, rep("DJ"))
names(DJ100H) <- eventName 
List <- rbind(List, DJ100H)


#DE100H
setwd("C:/Users/49688/Documents/simulation/pycharm/Eucalypt")

lines = read_lines("DE100H.txt", skip = 1)
lines
DE100H = data.frame(matrix(ncol = 4, nrow = 60))
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
lines = read_lines("ODC100H.txt", skip = 1)
lines
DC100H = data.frame(matrix(ncol = 4, nrow = 100))
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
DC100H <- cbind(DC100H[1:n-1,], rep("DC"))
DC100H
names(DC100H) <- Names
DC100H <- DC100H[c(1,4,5)]
DC100H <- melt(DC100H)
DC100H
names(DC100H) <- c("Conditions","Events","Differences")
DC100H
List <- rbind(List,DC100H)

#SC100H
lines = read_lines("OSC100H.txt", skip = 1)
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
  }
}
SC100H <- cbind(SC100H[1:n-1,], rep("SC"))
SC100H
names(SC100H) <- Names
SC100H <- SC100H[c(1,5)]
SC100H <- melt(SC100H)
SC100H
names(SC100H) <- c("Conditions","Events","Differences")
SC100H
List <- rbind(List,SC100H)

#TreeCollapse100H
setwd("C:/Users/49688/Documents/simulation/pycharm/TreeCollapse")
DTC100H = read.csv("OTC100H.txt",header = TRUE, sep =" ")
DTC100H
DTC100H <-melt(DTC100H)
DTC100H <- cbind(DTC100H, rep("TC"))
names(DTC100H) <- eventName 
List <- rbind(List, DTC100H)

levels(List$Conditions)

#aNova and TukeyHSD
# one row for four plots
par(mfrow=c(1,4))
#Anova and Turkey test
# self defined Turkey test plot function 
tuk_plot <- function (t, x, ...) 
{
  for (i in seq_along(x)) {
    xi <- x[[i]][, -4L, drop = FALSE]
    yvals <- nrow(xi):1L
    dev.hold()
    on.exit(dev.flush())
    plot(c(xi[, "lwr"], xi[, "upr"]), rep.int(yvals, 
                                              2L), type = "n", axes = FALSE, xlab = "", 
         ylab = "", main = NULL, ...)
    axis(1, ...)
    axis(2, at = nrow(xi):1, labels = dimnames(xi)[[1L]], 
         srt = 0, ...)
    abline(h = yvals, lty = 1, lwd = 0.5, col = "lightgray")
    abline(v = 0, lty = 2, lwd = 0.5, ...)
    segments(xi[, "lwr"], yvals, xi[, "upr"], 
             yvals, ...)
    segments(as.vector(xi), rep.int(yvals - 0.1, 3L), as.vector(xi), 
             rep.int(yvals + 0.1, 3L), ...)
    str <- paste0("% family-wise confidence level of ", t,"\n")
    title(main = paste0(t), 
          xlab = paste("Differences in mean levels of", 
                       names(x)[i]))
    box()
    dev.flush()
    on.exit()
  }
}

#Cospeciation
co <- List[which(List$Events == "Cospeciation"),][c("Differences","Conditions")]
#Computes summary of statistics by groups
#anova
co.aov <- aov(Differences ~ Conditions, co)
summary(co.aov)
#tukey
co.tk <- TukeyHSD(co.aov)
co.tk
# Tuckey test representation :
tuk_plot("Cospeication", co.tk , las=1 , col="brown")

#Duplication
du <- List[which(List$Events == "Duplication"),][c(2,3)]
#Computes summary of statistics by groups
#anova
du.aov <- aov(Differences ~ Conditions, du)
#tukey
du.tk <- TukeyHSD(du.aov)
du.tk
# Tuckey test representation :
tuk_plot("Duplication", du.tk , las=1 , col="brown")

#Host switch
e <- List[which(List$Events == "Switch"),][c(2,3)]
#Computes summary of statistics by groups
#anova
aov <- aov(Differences ~ Conditions, e)
#tukey
tk <- TukeyHSD(aov)
# Tuckey test representation :
tuk_plot("Host Switching", tk , las=1 , col="brown")

#Sorting
e <- List[which(List$Events == "Sorting"),][c(2,3)]
#Computes summary of statistics by groups
#anova
aov <- aov(Differences ~ Conditions, e)
#tukey
tk <- TukeyHSD(aov)
# Tuckey test representation :
tuk_plot("Sorting", tk , las=1 , col="brown")
mtext("95% family-wise of confidence level", side = 3, line = -1.5, outer = TRUE)
