#Accetable simulations search script, because the collection in linux is slow. 
#This script is optional, because the bash script 'generator' can automatically simulate and collect accetable samples.
# This script requires the unchecked simulations generated firstly, then this script can collect the accetable onees
library(dplyr)
# the path to Hepadnaviridae small samples with 46 leaves, we can change it according to the need
setwd("C:/Users/49688/Documents/simulation/HepSimulation")
#Read the file where the number of events is contained
myFiles <- list.files(pattern = "*.reco")
j <- data.frame(matrix(ncol = 6, nrow = length(myFiles)))
names <- c("num","index", "cor","sor","dur","hsr")
colnames(j)<- names
pass <- data.frame(filename = character(), cor = numeric(), sor = numeric(), dur = numeric(), hsr = numeric())
# i is variable according to the number of samples found, otherwise the script may cover the previous files
i = 0
for (val in myFiles)
{
  con = scan(val, what = "numerical", sep = " ")
  name <- val
  #Get the number of each event
  cor <- as.numeric(con[2])/(as.numeric(con[2]) + as.numeric(con[3]) + as.numeric(con[4]) + as.numeric(con[5]))
  sor <- as.numeric(con[3])/(as.numeric(con[2]) + as.numeric(con[3]) + as.numeric(con[4]) + as.numeric(con[5]))
  dur <- as.numeric(con[4])/(as.numeric(con[2]) + as.numeric(con[3]) + as.numeric(con[4]) + as.numeric(con[5]))
  hsr <- as.numeric(con[5])/(as.numeric(con[2]) + as.numeric(con[3]) + as.numeric(con[4]) + as.numeric(con[5]))
  con[2]
  # check if passing the criterions
  if ((cor >= 0.4) & (cor <=0.45) & (hsr >= 0.4) & (hsr <= 0.58) & (dur >= 0) & (dur <= 0.02) & (sor >= 0.05) & (sor <= 0.17))
  { 
    #If so, the related outputs from CoRe-Gen will be transferred to corresponding folder
    i = i + 1
    filen = sub("\\..*","", val)
    fileReco = paste0(filen,".reco")
    fileNex = paste0(filen, ".nex")
    fileTree = paste0(filen, ".tree")
    newPath <- "C:/Users/49688/Documents/simulation/HepSimulation/smallGroup"
    file.copy(from=fileReco, to=newPath, 
              overwrite = TRUE, recursive = FALSE, 
              copy.mode = TRUE)
    file.copy(from=fileNex, to=newPath, 
              overwrite = TRUE, recursive = FALSE, 
              copy.mode = TRUE)
    file.copy(from=fileTree, to=newPath, 
              overwrite = TRUE, recursive = FALSE, 
              copy.mode = TRUE)
    setwd("C:/Users/49688/Documents/simulation/HepSimulation/smallGroup")
    newReco = paste0("sample",i,".reco")
    newNex = paste0("sample",i,".nex")
    newTree = paste0("sample",i,".tree")
    file.rename(fileReco,newReco)
    file.rename(fileNex,newNex)
    file.rename(fileTree,newTree)
    setwd("C:/Users/49688/Documents/simulation/HepSimulation")
  }
}
