#DECoRe46H.txt  DCoRe100H.txt DCoRe111R
import os
# Function to get the differences between the solution found by tools and the correct solution, and the numbers of events found by tools
# path is path to the folder that contains the results from CoRe-ILP
def accuracy(output1, origin, path, pathToAns, l):
    output = open(output1, 'w')
    output.write("Cospeciation Duplication Host_Switch Sorting\n")
    output2 = open(origin, 'w')
    output2.write("Cospeciation Duplication Host_Switch Sorting\n")
    time = path + "Janetime"
    time = open(time,'r')
    time = time.readlines()
    #Get average number of events
    for i in range(0,l):
        fn1 = path + "output" + str(i)
        fn3 = path + "sample" + str(i)
        fn2 = pathToAns + "sample" + str(i) + ".reco"
        # If time is out, if so then write out of time and directly go next loo
        if (int(time[i].rstrip()) > 5400):
            output.write("OutOfTime\n")
            continue
        fileExist = False
        if (os.path.isfile(fn1) ==True):
            fileExist = True
            f1 = open(fn1,'r')
            lines = f1.readlines()
            tC = 0
            tS = 0
            tD = 0
            tH = 0
            g = 0
            on = False
            for line in lines:
                #There are some events being '?', namely the number is unknown
                if (on == True):
                    line = line.split()
                    if (line[0] != '?'):
                        tC = float(line[0])
                    else:
                        tC = '?'
                    if (line[1] != '?'):
                        tD = float(line[1])
                    else:
                        tD = '?'
                    if (line[2] != "?"):
                        tH = float(line[2])
                    else:
                        tH = '?'
                    if (line[3] != "?"):
                        tS = float(line[3])
                    else:
                        tS = '?'
                    break
                if(line.find("EVENTS") != -1):
                    on = True
        else:
            output.write("NoSolution\n")
            continue


        f2 = open(fn2, 'r')
        lines = f2.read().splitlines()
        aC = float(lines[1].split()[0])
        aS = float(lines[1].split()[1])
        aD = float(lines[1].split()[2])
        aH = float(lines[1].split()[3])
        #Write the differnce or just '?' and write the values in solutions from CoRe-ILP
        if (tC != '?'):
            output.write(format(float(float(tC) - aC),'.2f') + " ")
            output2.write(str(float(tC)) + " ")

        else:
            output.write(format(tC) + " ")
            output2.write(format(tC) + " ")
        if (tD != '?'):
            output.write(format(float(float(tD) - aD),'.2f') + " " )
            output2.write(str(float(tD)) + " ")
        else:
            output.write(format(tD) + " ")
            output2.write(format(tD) + " ")
        if (tH != '?'):
            output.write(format(float(float(tH) - aH),'.2f') + " ")
            output2.write(str(float(tH)) + " ")
        else:
            output.write(format(tH) + " ")
            output2.write(format(tH) + " ")
        if (tS != '?'):
            output.write(format(float(float(tS) - aS),'.2f'))
            output2.write(str(float(tS)))
        else:
            output.write(format(tS))
            output2.write(format(tS))
        output.write("\n" )
        output2.write("\n")
    output.close()
    output2.close()
# path to the simulation samples
pathToAns = "C:/Users/49688/Documents/simulation/hepadnaviridae_dir/largenum/"
pathToS = "C:/Users/49688/Documents/simulation/HepSimulation/smallGroup/"
pathToR = "C:/Users/49688/Documents/simulation/Retroviridae_dir/samples/"
#46
accuracy("DC46H.txt", "ODC46H.txt", "C:/Users/49688/Documents/simulation/DC46/", pathToS, 60)
accuracy("SC46H.txt", "OSC46H.txt", "C:/Users/49688/Documents/simulation/SC46/", pathToS, 60)

#100
accuracy("DC100H.txt", "ODC100H.txt", "C:/Users/49688/Documents/simulation/DCoRe100H/", pathToAns, 40)
accuracy("SC100H.txt", "OSC100H.txt", "C:/Users/49688/Documents/simulation/SCoRe100H/", pathToAns, 40)

#111
accuracy("DC111R.txt", "ODC111R.txt", "C:/Users/49688/Documents/simulation/DCoRe111R/", pathToR, 40)
accuracy("SC111R.txt", "OSC111R.txt", "C:/Users/49688/Documents/simulation/SCoRe111R/", pathToR, 40)
