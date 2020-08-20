# To generate the figure 8, the scatter plot of 10000 simulations and check the ratio of host choosing if we input 0.28 and the number of  accetpable samples 
library(ggplot2)
library("reshape2")
library(dplyr)

#HC282: HC 0.28 sw 0.93 co 0.85 l 111
setwd("C:/Users/49688/Documents/simulation/coreT/finalSimulation")
myFiles <- list.files(pattern = "*.reco")
j <- data.frame(matrix(ncol = 6, nrow = length(myFiles)))
# label the columns
names <- c("num","index", "cor","sor","dur","hsr")
colnames(j)<- names
i = 0
#get the ratios of each event
for (val in myFiles)
{
  con = scan(val, what = "numerical", sep = " ")
  i = i + 1
  j$num[i] = (as.numeric(con[2]) + as.numeric(con[3]))/(as.numeric(con[2]) + as.numeric(con[3]) + as.numeric(con[4]) + as.numeric(con[5]))
  j$index[i] = i
  j$cor[i] = as.numeric(con[2])/(as.numeric(con[2]) + as.numeric(con[3]) + as.numeric(con[4]) + as.numeric(con[5]))
  j$sor[i] = as.numeric(con[3])/(as.numeric(con[2]) + as.numeric(con[3]) + as.numeric(con[4]) + as.numeric(con[5]))
  j$dur[i] = as.numeric(con[4])/(as.numeric(con[2]) + as.numeric(con[3]) + as.numeric(con[4]) + as.numeric(con[5]))
  j$hsr[i] = as.numeric(con[5])/(as.numeric(con[2]) + as.numeric(con[3]) + as.numeric(con[4]) + as.numeric(con[5]))
}

#Mark suitable Retroviridae simulation
#pass <- j[which((j$cor >= 0.2) & (j$cor <= 0.3) & (j$hsr >= 0.62) & (j$hsr <= 0.72) & (j$dur >= 0) & (j$dur <= 0.1) & (j$sor >= 0) & (j$sor <= 0.08)),]
TruePass <- rep(FALSE, times = 10000)
j <- cbind(j, TruePass)
j[which((j$cor >= 0.2) & (j$cor <= 0.3) & (j$hsr >= 0.62) & (j$hsr <= 0.72) & (j$dur >= 0) & (j$dur <= 0.1) & (j$sor >= 0) & (j$sor <= 0.08)),7] <- TRUE
 # The disperse plot of Ratio of host choosing in each simulation
p <- ggplot(data = j, aes(x = index, y = num, color = TruePass)) + geom_point() + geom_hline(yintercept = 0.28, linetype="dashed",color = 'red') 
p  + labs(x = 'The index of simulations', y = 'The ratio of host choosing over the total events', title = 'Host Choosing = 0.28; Cospeciation = 0.85; Host Switch = 0.93')


