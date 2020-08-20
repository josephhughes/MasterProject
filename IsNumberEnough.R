#Check if the number of simulations in each combination of conditions is 3000, if no then that group would be recorded into a text file
# loop to generate complete path
start = "C:/Users/49688/Documents/simulation/coreT/"
cog = c("co0", "co2", "co4", "co6", "co8", "co1")
hcg = c("hc0", "hc2", "hc4", "hc6", "hc8", "hc1")
swg = c("sw0", "sw2", "sw4", "sw6", "sw8", "sw1")
tipsg = c("s200")
lackGrid <- c()
i = 0
for(s in tipsg)
{
  for(codir in cog)
  {
    for (hcdir in hcg)
    {
      for(swdir in swg)
      {
        folder <- paste0(start, s, "/", codir, "/", hcdir, "/", swdir, "/")
        # Enter the path and check the number of files. if lower than 3000, the folder would be recoreded in a vector 
        setwd(folder)
        f <- list.files(pattern = "*.reco")
        if (length(f) < 3000)
        {
          i = i + 1
          lackGrid[i] <- folder
          
        }
      }
    }
  }
}
i
lackGrid
# Get three files for each group in 25, 100, 200 leaves
lapply(lackGrid, write, "lackText3.txt", append= TRUE, ncolumns = 1000)
