# Making the confidence intervals plot of the results about 46 leaves samples in figure 11
# before 140 is similar to boxplotMaker, but here the correct number of each event and the number inferred by tools are collected
library(dplyr)
library(reshape2)
library(ggplot2)
library(readr)

Names <- c("Cospeciation","Duplication","Switch","Sorting","Groups")
eventName = c("Events","Differences", "Conditions")
mName <- c("Conditions","Events","Differences")
#46H answer
setwd("C:/Users/49688/Documents/simulation/pycharm")
r46H = read.csv("r46H.txt",header = TRUE, sep =" ")
r46H <-melt(r46H)
r46H <- cbind(r46H, rep("Ans"))
names(r46H) <- eventName 
List <- r46H

setwd("C:/Users/49688/Documents/simulation/pycharm/Janes")
#DJ46H
DJ46H = read.csv("ODJ46H.txt",header = TRUE, sep =" ")
DJ46H <-melt(DJ46H)
DJ46H <- cbind(DJ46H, rep("DJ"))
names(DJ46H) <- eventName 
List <- rbind(List, DJ46H)

# #SJ46H
# SJ46H = read.csv("OSJ46H.txt",header = TRUE, sep =" ")
# SJ46H <-melt(SJ46H)
# SJ46H <- cbind(SJ46H, rep("SJ"))
# names(SJ46H) <- eventName 
# List <- rbind(List, SJ46H)
# List

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

#SE46H
# lines = read_lines("OSE46H.txt", skip = 1)
# lines
# SE46H = data.frame(matrix(ncol = 4, nrow = 60))
# n = 1
# for (line in lines)
# {
#   line = strsplit(line, "\\s+")[[1]]
#   if (grepl("Solution", line) == FALSE && grepl("Time",line) == FALSE)
#   {
#     SE46H[n,1] <- as.numeric(line[1])
#     SE46H[n,2] <- as.numeric(line[2])
#     SE46H[n,3] <- as.numeric(line[3])
#     SE46H[n,4] <- as.numeric(line[4])
#     n = n + 1
#   }
# }
# SE46H <- cbind(SE46H[1:n-1,], rep("SE"))
# names(SE46H) <- Names
# SE46H <- melt(SE46H)
# names(SE46H) <- mName
# # SE46H
# List <- rbind(List, SE46H)
# List

setwd("C:/Users/49688/Documents/simulation/pycharm/CoRe")
#DC46H
lines = read_lines("ODC46H.txt", skip = 1)
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
lines = read_lines("OSC46H.txt", skip = 1)
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
DTC46H = read.csv("OTC46H.txt",header = TRUE, sep =" ")
DTC46H
DTC46H <-melt(DTC46H)
DTC46H <- cbind(DTC46H, rep("TC"))
names(DTC46H) <- eventName 
List <- rbind(List, DTC46H)

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
co.aov <- aov(Differences ~ Conditions, co)
summary(co.aov)
co.tk <- TukeyHSD(co.aov)
co.tk

# Tuckey test representation :
#plot(co.tk , las=1 , col="brown")
tuk_plot("Cospeication", co.tk , las=1 , col="brown")
#Duplication
du <- List[which(List$Events == "Duplication"),][c(2,3)]
#Computes summary of statistics by groups
du.aov <- aov(Differences ~ Conditions, du)
du.tk <- TukeyHSD(du.aov)
du.tk
# Tuckey test representation :
#plot(du.tk , las=1 , col="brown")
tuk_plot("Duplication", du.tk , las=1 , col="brown")
#Host switch
e <- List[which(List$Events == "Switch"),][c(2,3)]
#Computes summary of statistics by groups
aov <- aov(Differences ~ Conditions, e)
tk <- TukeyHSD(aov)
# Tuckey test representation :
#plot(tk , las=1 , col="brown")
tuk_plot("Host Switching", tk , las=1 , col="brown")
#Sorting
e <- List[which(List$Events == "Sorting"),][c(2,3)]
#Computes summary of statistics by groups
aov <- aov(Differences ~ Conditions, e)
tk <- TukeyHSD(aov)
# Tuckey test representation :
tuk_plot("Sorting", tk , las=1 , col="brown")
mtext("95% family-wise of confidence level", side = 3, line = -1.5, outer = TRUE)
