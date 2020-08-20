#Get the number of host-parasite interactions, gene combinations between hantavirus segments and cytb
input = open("finalOutput.txt")
interactions = {}
hostNum = []
n = 0
#the elements in each lines
for line in input.readlines():
    elements = line.split(";")

#the number of combination between L, S, M and cymb
    if (elements[5] != "" and elements[0] != ""):
        # if the virus name has been added into keys
        if(elements[0] in interactions.keys()):
            # if the host name hasn't been added into the array of values
            isL = False
            isM = False
            isS = False

            if (elements[5] not in interactions[elements[0]].keys()):
                if (elements[2] != ""):
                    isL = True
                if (elements[3] != ""):
                    isM = True
                if (elements[4] != ""):
                    isS = True

                interactions[elements[0]][elements[5]] = [elements[6], elements[7],isL, isM, isS]

                if (elements[5] not in hostNum):
                    hostNum.append(elements[5])
            # if the host name has been added into the array of values but
            elif (elements[5] in interactions[elements[0]].keys()):
                cytb = elements[6].split("|")
               #judge which segemnts are in the row
                if (elements[2] != ""):
                    isL = True
                if (elements[3] != ""):
                    isM = True
                if (elements[4] != ""):
                    isS = True
                if (isL == True):
                    interactions[elements[0]][elements[5]][2] = True
                if (isM == True):
                    interactions[elements[0]][elements[5]][3] = True
                if (isS == True):
                    interactions[elements[0]][elements[5]][4] = True
                #add accession number to the dictionary if not added yet
                for access in cytb:
                    if (access not in interactions[elements[0]][elements[5]][0]):
                        interactions[elements[0]][elements[5]][0] += access + "|"
                coi = elements[7].split("|")
                for access in coi:
                    if (access not in interactions[elements[0]][elements[5]][1]):
                        interactions[elements[0]][elements[5]][1] += access + "|"
        else:
            #If the host name hasn't been added to the dictionary, then add it as a inner key and add the related information including if the segments S.L, or M contained in the row 
            interactions[elements[0]] = {}
            if (elements[2] != ""):
                isL = True
            if (elements[3] != ""):
                isM = True
            if (elements[4] != ""):
                isS = True
            interactions[elements[0]][elements[5]] = [elements[6],elements[7], isL, isM, isS]

output = open("InteractionInf.txt",'w')
intNum = 0
p = 0
cytb = 0
coi = 0
com = 0
Lcom = 0
Mcom = 0
Scom = 0
#write output into file
for key in interactions.keys():
    output.write("Parasite:" + key + "\n")
    p += 1
    #Count numbers
    for k in interactions[key]:
                intNum += 1
                output.write("Host:" + k + "\n")
                output.write(str(interactions[key][k][0] + "\n"))
                output.write(str(interactions[key][k][1] + "\n"))
                if (interactions[key][k][0] != "" and interactions[key][k][0] != "" ):
                    if (interactions[key][k][2] == True):
                        Lcom = Lcom + 1
                    if (interactions[key][k][3] == True):
                        Mcom = Mcom + 1
                    if (interactions[key][k][4] == True):
                        Scom = Scom + 1
    output.write("// " + str(len(interactions[key])) + "\n")
    
output.write("Number of Parasite: " + str(p) + "\n")
output.write("Number of Host: " + str(len(hostNum)) + "\n")
output.write("Number of Interactions: " + str(intNum) + "\n")
output.write("Number of Combination between cymb and L: " + str(Lcom) + "\n")
output.write("Number of Combination between cymb and M: " + str(Mcom) + "\n")
output.write("Number of Combination between cymb and S: " + str(Scom))
output.close
