#DJ46H.txt DJ100H.txt DJ111R
# Function to get the differences between the solution found by tools and the correct solution, and the nnumbers of eveents found by tools
# This script is little special that it also records the number of events in the correct solutions.
def accuracy(output1, origin, realSolution, path, pathToAns, l):
    #For differences
    output = open(output1, 'w')
    output.write("Cospeciation Duplication Switch Sorting\n")
    # For the original values from solutions found by tools
    output2 = open(origin, 'w')
    output2.write("Cospeciation Duplication Switch Sorting\n")
    # For the correct values of events
    output3 = open(realSolution, 'w')
    output3.write("Cospeciation Duplication Switch Sorting\n")
    #l can be 60 or 40
    for i in range(0,l):
        #paste the path of file and create the file in that path
        fn1 = path + "sample" + str(i)
        fn2 = pathToAns + "sample" + str(i) + ".reco"
        f1 = open(fn1,'r')
        # Get the lines from the chosen file 
        lines = f1.read().splitlines()
        # Get the number of events from lines
        tC = float(lines[-6].split()[-1])
        tD = float(lines[-5].split()[-1])
        tH = float(lines[-4].split()[-1])
        # Jane 4 has two event, loss and fail to diverge, and sorting event is the sum of these two events. Therefore, we add the number of them together
        tS = float(lines[-3].split()[-1]) + float(lines[-2].split()[-1])
        # To get the number of events from the correct solution
        f2 = open(fn2, 'r')
        lines = f2.read().splitlines()
        aC = float(lines[1].split()[0])
        aS = float(lines[1].split()[1])
        aD = float(lines[1].split()[2])
        aH = float(lines[1].split()[3])
        # write the four differences to the file1 by line
        output.write(str(float(tC - aC)) + " ")
        output.write(str(float(tD - aD)) + " " )
        output.write(str(float(tH - aH)) + " ")
        output.write(str(float(tS - aS)))
        output.write("\n" )
        # Write the number of events to the file 2 by line
        output2.write(str(float(tC)) + " ")
        output2.write(str(float(tD)) + " ")
        output2.write(str(float(tH)) + " ")
        output2.write(str(float(tS)))
        output2.write("\n")
        # Write the correct number of events to file 3 by line
        output3.write(str(float(aC)) + " ")
        output3.write(str(float(aD)) + " ")
        output3.write(str(float(aH)) + " ")
        output3.write(str(float(aS)))
        output3.write("\n")
    output.close()
    output2.close()
    output3.close()
# path to the specific folders where the corresponding samples are in
pathToAns = "C:/Users/49688/Documents/simulation/hepadnaviridae_dir/largenum/"
pathToS = "C:/Users/49688/Documents/simulation/HepSimulation/smallGroup/"
pathToR = "C:/Users/49688/Documents/simulation/Retroviridae_dir/samples/"

#46
accuracy("DJ46H.txt", "ODJ46H.txt", "r46H.txt", "C:/Users/49688/Documents/simulation/DJ46/", pathToS, 60)
#100
accuracy("DJ100H.txt", "ODJ100H.txt", "r100H.txt", "C:/Users/49688/Documents/simulation/DJanes100H/", pathToAns, 40)
#111
accuracy("DJ111R.txt", "ODJ111R.txt", "r111R.txt", "C:/Users/49688/Documents/simulation/DJanes111R/", pathToR, 40)
