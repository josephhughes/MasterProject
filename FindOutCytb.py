#Accoring to the result from esearch Making a list with the information of CYTB and COI
import re
# the output of path from esearch
pathTogb = "C:/Users/49688/Documents/simulation/gb3/"
#The information collected by CatchKey.py
pathToInf = "C:/Users/49688/Documents/simulation/pycharm/output.txt"

f1 = open(pathToInf, "r")
inf = f1.readlines()
hostList = {}
Lines = []

#make dictionary by without repeating hostname
for line in inf:
    line = line.split(";")
    Lines.append(line)
    if (not line[-2] in hostList) and (line[-2] != ""):
        hostList[line[-2]] = ["",""]

oLines = []
keys = hostList.keys()
#We have known the number of files
for i in range(0,335):
    fn = pathTogb + "output" + str(i) + ".txt"
    f2 = open(fn, "r")
    oLines = f2.readlines()
    on = False
    quoted = re.compile('"[^"]*"')
    gene = ""
    synoym = ""
    cytb = False
    name = ""
    for line in oLines:
        #'//' means the finish of one sample
        if (line.find("//\n") != -1):
            name = ""
            on = False
            cytb = False
            coi = False
            access = ""
        #getAccession number
        if (line.find("ACCESSION") != -1):
            access = line.split()[1]
        # get name
        if (line.find("ORGANISM") != -1):
            for i in line.split()[1:]:
                name += i + " "
            name = name[:-1]
            if name in keys and name != "":
                on = True
        if (on == True):
            #get gene name
            if (line.find("/gene=") != -1):
                value= quoted.findall(line)
                if value:
                    value[0] = value[0][1:]
                    gene = str(value[0][:-1])
                    #judge if gene is cytb
                    if(gene == "CYTB"):
                        cytb = True
            
            if (line.find("/gene_synonym") != -1):
                value = quoted.findall(line)
                if value:
                    value[0] = value[0][1:]
                    synoym = value[0][:-1]
                    if (synoym.find("CYTB") != -1 ):
                        cytb = True
            # If find cytb, add accession number into dictionary
            if ((cytb == True and access not in hostList[name][0])):
                hostList[name][0] = str(hostList[name][0]) + access + "|"
            # this way can judge coi
            if (line.find("/gene=") != -1):
                value= quoted.findall(line)
                if value:
                    value[0] = value[0][1:]
                    gene = str(value[0][:-1])
                    if(gene == "COI"):
                        coi = True

            if (line.find("/gene_synonym") != -1):
                value = quoted.findall(line)
                if value:
                    value[0] = value[0][1:]
                    synoym = value[0][:-1]
                    if (synoym.find("COI") != -1 ):
                        coi = True
            #If find coi, add accession number into dictionary
            if ((coi == True and access not in hostList[name][1])):
                hostList[name][1] = str(hostList[name][1]) + access + "|"
    f2.close()

#Store the complete information to output file
output = open("finalOutput.txt", "w")
output.write("#Virus; Isolate name; L accession; M accession; S accession; Host name; accession number of CYTB; accession number of COI")
for line in inf:
    line = line.split(";")
    for key in hostList.keys():
        if line[-2] == key:
            output.write(str(line[0]) + ";" + str(line[1]) + ";" + str(line[2]) + ";" + str(line[3]) + ";" + str(line[4]) + ";" + str(line[5]) + ";" + str(hostList[key][0]) + ";" + str(hostList[key][1]) + ";" + "\n")


output.close()
f1.close()
