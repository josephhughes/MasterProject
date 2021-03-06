#DTC46H.txt DTC100H.txt DTC111R
import re
# Function to get the differences between the solution found by tools and the correct solution, and the numbers of events found by tools， similar to Jane 4's one
def accuracy(output1,origin, path, pathToAns, l):
    #For differences
    output = open(output1, 'w')
    output.write("Cospeciation Duplication Switch Sorting\n")
    #For the number of events found by tool
    output2 = open(origin, 'w')
    output2.write("Cospeciation Duplication Switch Sorting\n")
    for i in range(0,l):
        #Get the number of events found by TreeCollapse
        fn1 = path + "output" + str(i) + ".txt"
        fn2 = pathToAns + "sample" + str(i) + ".reco"
        f1 = open(fn1,'r')
        lines = f1.read().splitlines()
        line = re.findall('\d+', lines[0])
        tC = float(line[0])
        tD = float(line[1])
        tH = float(line[2])
        tS = float(line[3])
        
        # Get the correct number of events
        f2 = open(fn2, 'r')
        lines = f2.read().splitlines()
        aC = float(lines[1].split()[0])
        aS = float(lines[1].split()[1])
        aD = float(lines[1].split()[2])
        aH = float(lines[1].split()[3])
        # Write the differences into file1 
        output.write(str(float(tC - aC)) + " ")
        output.write(str(float(tD - aD)) + " " )
        output.write(str(float(tH - aH)) + " ")
        output.write(str(float(tS - aS)))
        output.write("\n" )
        # Write the numbers found by the tool into file 2
        output2.write(str(float(tC)) + " ")
        output2.write(str(float(tD)) + " ")
        output2.write(str(float(tH)) + " ")
        output2.write(str(float(tS)))
        output2.write("\n")
    output.close()
    output2.close()
    
# path to the specific folders where the corresponding samples are in
pathToAns = "C:/Users/49688/Documents/simulation/hepadnaviridae_dir/largenum/"
pathToS = "C:/Users/49688/Documents/simulation/HepSimulation/smallGroup/"
pathToR = "C:/Users/49688/Documents/simulation/Retroviridae_dir/samples/"
#46
accuracy("DTC46H.txt","OTC46H.txt", "C:/Users/49688/Documents/simulation/DTC46H/", pathToS, 60)

#100
accuracy("DTC100H.txt","OTC100H.txt", "C:/Users/49688/Documents/simulation/DTC100H/", pathToAns, 40)

#111
accuracy("DTC111R.txt", "OTC111R.txt", "C:/Users/49688/Documents/simulation/DTC111R/", pathToR, 40)
