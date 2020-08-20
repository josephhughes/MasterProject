#Check the simulations if are acceptable and record the number of acceptable simulations in each conditions 
# declare the variables and make data.frame which can knock together to be the complete condition according to the cooridnates in dataframe
cog = c("co0", "co2", "co4", "co6", "co8", "co1")
hcg = c("hc0", "hc2", "hc4", "hc6", "hc8", "hc1")
swg = c("sw0", "sw2", "sw4", "sw6", "sw8", "sw1")
tipsg = c("s25","s100","s200")
co0 = data.frame(matrix(ncol = 6, nrow = 6))
colnames(co0) <- swg
rownames(co0) <- hcg
co2 = data.frame(matrix(ncol = 6, nrow = 6))
colnames(co2) <- swg
rownames(co2) <- hcg
co4 = data.frame(matrix(ncol = 6, nrow = 6))
colnames(co4) <- swg
rownames(co4) <- hcg
co6 = data.frame(matrix(ncol = 6, nrow = 6))
colnames(co6) <- swg
rownames(co6) <- hcg
co8 = data.frame(matrix(ncol = 6, nrow = 6))
colnames(co8) <- swg
rownames(co8) <- hcg
co1 = data.frame(matrix(ncol = 6, nrow = 6))
colnames(co1) <- swg
rownames(co1) <- hcg

s25co0 = co0
s25co2 = co2
s25co4 = co4
s25co6 = co6
s25co8 = co8
s25co1 = co1

s100co0 = co0
s100co2 = co2
s100co4 = co4
s100co6 = co6
s100co8 = co8
s100co1 = co1

s200co0 = co0
s200co2 = co2
s200co4 = co4
s200co6 = co6
s200co8 = co8
s200co1 = co1

s25 <- data.frame(s25co0, s25co2, s25co4, s25co6, s25co8, s25co1)
s100 <- data.frame(s100co0, s100co2, s100co4, s100co6, s100co8, s100co1)
s200 <- data.frame(s200co0, s200co2, s200co4, s200co6, s200co8, s200co1)

# Switch to different dataframe in 25, 100, 200 to get 

#start = "C:/Users/49688/Documents/simulation/coreT/s25/"
#start = "C:/Users/49688/Documents/simulation/coreT/s100/"
start = "C:/Users/49688/Documents/simulation/coreT/s200/"
o <- 0
  for (codir in cog)
  {
    row <- 0
    for (hcdir in hcg)
    {
      row <- row + 1
      col <- o
      for (swdir in swg)
      {
        col <- col + 1
        # set path to the corresponding directory
        folder <- paste0(start, codir, "/", hcdir, "/", swdir, "/")
        setwd(folder)
        filenames <- paste0("simulation", 1:3000, ".reco")
        Hpass <- 0
        Rpass <- 0
        for (i in filenames)
        {
          con <- scan(i, what = "numerical", sep = " ")
          #Get the number of events
          co = as.numeric(con[2])
          so = as.numeric(con[3]) 
          du = as.numeric(con[4])
          hs = as.numeric(con[5])
          total = co + so + du + hs
          #Calculate the ratios of events
          if(total != 0)
          {
            cop = co/total
            sop = so/total
            dup = du/total
            hsp = hs/total
            #The acceptable Retroviridae samples screening
            if (dup >= 0 && dup <= 0.1 && sop >= 0 && sop <= 0.08)
            {
              if (cop >= 0.2 &&cop <= 0.3 && hsp >= 0.62 && hsp <= 0.72)
              {
                Rpass <- Rpass + 1
                Rpass
              }
            }
            #The acceptable Hepadnaviridae samples screening
            if (dup >= 0 && dup <= 0.02 && sop >= 0.05 && sop <= 0.17)
            {
              if (cop >= 0.4 &&cop <= 0.45 && hsp >= 0.4 && hsp <= 0.58)
              {
                Hpass <- Hpass + 1
                Hpass
              }
            }
          }
        }
       Htips[row,][col] <- Hpass
       Rtips[row,][col] <- Rpass
       
      }
    }
    o <- o + 6
  }
# Store the dataframe to csv file
setwd("C:/Users/49688/Documents/simulation/coreT")
write.csv(Htips,'HepadnaviridaeTableFinalS200.csv')
write.csv(Rtips,'RetroviridaeTableFinalS200.csv')
