#DEucalpyt46H.txt  DEucalpyt100H.txt DEucalpyt111R 
# Function to get the differences between the solution found by tools and the correct solution, and the numbers of events found by tools
def accuracy(output1, origin, path,pathToAns, l):
    # For differences
    output = open(output1, 'w')
    output.write("Cospeciation Duplication Switch Sorting\n")
    # For the original values from solutions found by tools
    output2 = open(origin, 'w')
    output2.write("Cospeciation Duplication Switch Sorting\n")
    #Get time, to check if time is out
    time = path + "Janetime"
    time = open(time,'r')
    time = time.readlines()
    #60  40
    #  Get average number of events
    for i in range(0,l):
        fn1 = path + "output" + str(i)
        fn2 = pathToAns + "sample" + str(i) + ".reco"
        # If time is out, if so then write out of time and directly go next loop
        if(int(time[i].rstrip()) > 5400):
            output.write("OutOfTime\n")
            continue
        f1 = open(fn1,'r')
        #Declare 0 to each event to wait adding
        lines = f1.read().splitlines()
        tC = 0
        tS = 0
        tD = 0
        tH = 0
        g = 0
        #judge if find acyclic, this line contains the number of events should be added to the corresponding variables
        on = False
        # judge if no solution, namely only cyclic solutions
        noSolution = True
        for line in lines:
            # find cyclic, do not record
            if(line.find("cyclic") != -1 and line.find("acyclic") == -1):
                on = False
                # find the acyclic, this line contains a number of one event
            if (line.find("(acyclic):") != -1):
                on = True
                #there are some reasonable solutions, so false
                noSolution = False
            #find cospeciation, add the number to the corresponding variable, and next few if statements are similar
            if (line.find("cospeciations") != -1 and on == True):
                tC += float(line.split()[-1])
                g += 1
            if (line.find("duplications") != -1 and on == True):
                tD += float(line.split()[-1])
            if (line.find("switches") != -1 and on == True):
                tH += float(line.split()[-1])
            if (line.find("losses") != -1 and on == True):
                tS += float(line.split()[-1])
        #if solution is probably time-inconsistent
        if (noSolution == True):
            output.write("NoAcyclicSolution\n")
            continue
        # get average of
        if(tC != 0):
            tC = tC/g
        if(tD != 0):
            tD = tD/g
        if (tH != 0):
            tH = tH/g
        if (tS != 0):
            tS = tS/g

        f2 = open(fn2, 'r')
        lines = f2.read().splitlines()
        aC = float(lines[1].split()[0])
        aS = float(lines[1].split()[1])
        aD = float(lines[1].split()[2])
        aH = float(lines[1].split()[3])
        #Get difference
        output.write(format(float(tC - aC),'.2f') + " " )
        output.write(format(float(tD - aD),'.2f') + " " )
        output.write(format(float(tH - aH),'.2f') + " ")
        output.write(format(float(tS - aS),'.2f'))
        output.write("\n" )
       # get the values in solutions
        output2.write(str(float(tC)) + " ")
        output2.write(str(float(tD)) + " ")
        output2.write(str(float(tH)) + " ")
        output2.write(str(float(tS)))
        output2.write("\n")
    output.close()


# path to the corresponding folders
pathToAns = "C:/Users/49688/Documents/simulation/hepadnaviridae_dir/largenum/"
pathToS = "C:/Users/49688/Documents/simulation/HepSimulation/smallGroup/"
pathToR = "C:/Users/49688/Documents/simulation/Retroviridae_dir/samples/"

#E46
accuracy("DE46H.txt", "ODE46H.txt", "C:/Users/49688/Documents/simulation/DE46/", pathToS,60)

#E46
accuracy("DE100H.txt", "ODE100H.txt", "C:/Users/49688/Documents/simulation/DEucalypt100H/", pathToAns,40)

#E11l
accuracy("DE111R.txt", "ODE111R.txt", "C:/Users/49688/Documents/simulation/DEucalypt111R/", pathToR,40)
