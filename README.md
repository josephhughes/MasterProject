# MasterProject
Script for testing cophylogenetic reconstruction tools
Procedures:
1. Large scale simulations.
    LargeScaleSimulation : simulate simulations for heatmaps.
      
2. Check the simulations and make the heatmaps for the simulations:
    CheckAllGroups.R: count the number of accetable simulations in each conditions from LargeScaleSimulation.
    IsNumberEnough: check the number of simulation in each combinatoin of conditions is enough or not.
    SupplyLackFolders: supply the number of simualtion in some cases when the folder does not have 3000 simulation.
    Supply1Case: supply the simulations for the cases when one of cospeciation, host switching, or host choosing to be 1.
    HeatMapMaker1.R : heatmaps in figure 6 and 7
    
3. Generate another group of simulations and make the scatter plot:
    The simulation for figure 8 is by direct command: java -jar CoRe-Gen.jar -m1 -l111 -c10000 -pco0.85 -psw0.93 -phc0.28
    HostChoosingCheck.R : made heatmap in figure 8. 
    
4. Simulate the Retorviridae and Hepadnaviridae datasets:
    SimulationGenerator: generate accetable hepadnaviridae simulations.
    RetroviridaeGenerator (alternative): generate accetable retroviridae simulations.
    AccetableSampleSearch.R (alternative) : find out accetable retroviridae simulations.
    
5. Run the tools to find solution for the simulations and get the values of events from solutions found by tools and the differences in each event between the solutions found by    tools and the correct solutions.
    Tool running:
    Tool4 :EUCALYPT, Jane, CoRe-ILP, TreeCollapse running
    runTreeMap.bat (failed to find solutions, because the termination of running is failed)
    
    Get the numbers and the differences of events:
      CoReILP_Accuracy.py
      EUCALYPT_accuracy.py
      Jane4_Accuracy.py
      TreeCollapse_Accuracy.py
    
5. Make the boxplots based on the differences between the number of each event from the solutions found by tools and the correct solutions (figure 11).
    BoxPlot46.R
    BoxPlot100.R
    BoxPlot111.R
    
6. Make the boxplots and confidence intervals based on the time consumption of each tool, and the solution-time boxplot for 100 leaves hepadnaviridae samples by EUCALYPT is made (figure 10). 
   Boxplots in Figure 9 and 10:
    TimeBoxPlot46.R
    TimeBoxPlot100.R
    TimeBoxPlot111.R

7. Do ANOVA statistics and then tukey test. the results of tukey test are drawed to the confidence intervals plots in figure 11 and 9, and ANOVA results are added into table 7. The infomation about hantavirus is downloaded from NCBI, and the hostname, virus name and the accession number, and the accesssion number of virus segment seuqnced are collected.
    Table 7:
      Tablemaker46.R
      Tablemaker100.R
      Tablemaker111.R
      anova46.R
      anova100.R
      anova111.R
    Figure 11:
     anova46.R
     anova100.R
     anova111.R

8. Using ’txid1980413[Organism:exp] AND (viruses[filter] AND is_nuccore[filter])’ to search host name and cytb to get the information of the hosts which have the gene cytb.
9. Connect the information of hantavirus and hosts, and make a statistics of the interactions between hosts and hantavirus, and the gene combination between the host gene cytb and the virus segment, to decide which segemnt is suitable to reconstruct maximum likelihood trees of hantavirus and their hosts in future.
    Search in NCBI: txid1980413[Organism:exp] AND (viruses[filter] AND is_nuccore[filter])
    CatchKey.py: find the information of host and the complete information of samples of hantavirus
  The host names are screened by the gene cytb by esearch and efetch: esearch -db nuccore -query "Myodes glareolus AND refseq[filter] AND cytochrome b" | efetch -format gb
  The number of hantavirus-host interactions and gene combination:
    InteractionCounter.py


