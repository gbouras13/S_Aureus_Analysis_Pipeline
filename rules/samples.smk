"""
Function for parsing the 'Assemblies' config and identifying samples and read files
"""

from itertools import chain


def samplesFromCsv(csvFile):
    """Read samples and files from a CSV"""
    outDict = {}
    with open(csvFile,'r') as csv:
        for line in csv:
            l = line.strip().split(',')
            if len(l) == 5:
                outDict[l[0]] = {}
                if os.path.isfile(l[1]):
                    outDict[l[0]]['Chromosome'] = l[1]
                else:
                    sys.stderr.write("\n"
                                     f"    FATAL: Error parsing {csvFile}. The chromosome fasta file \n"
                                     f"    {l[1]} \n"
                                     "    does not exist. Check formatting, and that \n" 
                                     "    file names and file paths are correct.\n"
                                     "\n")
                    sys.exit(1)
                # if no plasmids, then code as "None"
                if os.path.isfile(l[2]):
                    outDict[l[0]]['Plasmids'] = l[2]
                else:
                    outDict[l[0]]['Plasmids'] = "None"
                # get the short reads 
                if os.path.isfile(l[3]) and os.path.isfile(l[4]):
                    outDict[l[0]]['R1'] = l[3]
                    outDict[l[0]]['R2'] = l[4]
                else:
                    sys.stderr.write("\n"
                                     f"    FATAL: Error parsing {csvFile}. The fastq files \n"
                                     f"    {l[3]} or \n"
                                     f"    {l[4]} \n"
                                     "    do not exist. Check formatting, and that \n" 
                                     "    file names and file paths are correct.\n"
                                     "\n")
                    sys.exit(1)
    return outDict

def plasmidSamplesFromCsv(csvFile):
    """Read plasmid and files from a CSV"""
    outDict = {}
    with open(csvFile,'r') as csv:
        for line in csv:
            l = line.strip().split(',')
            # get only the lines without "None"
            if l[2] != "None":
                if len(l) == 5:
                    outDict[l[0]] = {}
                    if os.path.isfile(l[1]) and os.path.isfile(l[2]):
                        outDict[l[0]]['Chromosome'] = l[1]
                        outDict[l[0]]['Plasmids'] = l[2]
                    else:
                        sys.stderr.write("\n"
                                        f"    FATAL: Error parsing {csvFile}. The chromosome fasta file \n"
                                        f"    {l[1]} \n"
                                        "    does not exist. Check formatting, and that \n" 
                                        "    file names and file paths are correct.\n"
                                        "\n")
                        sys.exit(1)
    return outDict

def nonPlasmidSamplesFromCsv(csvFile):
    """Read plasmid and files from a CSV"""
    outDict = {}
    with open(csvFile,'r') as csv:
        for line in csv:
            l = line.strip().split(',')
            # only those with none
            if l[2] == "None":
                if len(l) == 5:
                    outDict[l[0]] = {}
                    # plasmid samples need to be "None"
                    if os.path.isfile(l[1]) and l[2] == "None":
                        outDict[l[0]]['Chromosome'] = l[1]
    return outDict


def parseSamples(csvfile):
    # for reading from directory
    #if os.path.isdir(readFileDir):
    #   sampleDict = samplesFromDirectory(readFileDir)
    if os.path.isfile(csvfile):
        sampleDict = samplesFromCsv(csvfile)
    else:
        sys.stderr.write("\n"
                         f"    FATAL: {csvfile} is neither a file nor directory.\n"
                         "\n")
        sys.exit(1)
    if len(sampleDict.keys()) == 0:
        sys.stderr.write("\n"
                         "    FATAL: We could not detect any samples at all.\n"
                         "\n")
        sys.exit(1)
    return sampleDict




def gessFromCsv(csvFile):
    """Read gess samples and files from a CSV"""
    outDict = {}
    with open(csvFile,'r') as csv:
        for line in csv:
            l = line.strip().split(',')
            if len(l) == 8:
                outDict[l[0]] = {}
                if  os.path.isfile(l[4])  and os.path.isfile(l[5]) and os.path.isfile(l[6]) and os.path.isfile(l[7]) and os.path.isfile(l[8])  :
                    outDict[l[0]]['Gess'] = l[1]
                    outDict[l[0]]['T0'] = l[2]
                    outDict[l[0]]['T1'] = l[3]
                    outDict[l[0]]['T0_fasta'] = l[4]
                    outDict[l[0]]['T1_fasta'] = l[5]
                    outDict[l[0]]['T0_gbk'] = l[6]
                    outDict[l[0]]['T1_R1'] = l[7]
                    outDict[l[0]]['T1_R2'] = l[8]
                else:
                    sys.stderr.write("\n"
                                     f"    FATAL: Error parsing {csvFile}. The  file \n"
                                     f"    {l[1]} \n"
                                     "    does not exist. Check formatting, and that \n" 
                                     "    file names and file paths are correct.\n"
                                     "\n")
                    sys.exit(1)
    return outDict



def parseGess(csvfile):
    # for reading from directory
    #if os.path.isdir(readFileDir):
    #   sampleDict = samplesFromDirectory(readFileDir)
    if os.path.isfile(csvfile):
        sampleDict = gessFromCsv(csvfile)
    else:
        sys.stderr.write("\n"
                         f"    FATAL: {csvfile} is neither a file nor directory.\n"
                         "\n")
        sys.exit(1)
    if len(sampleDict.keys()) == 0:
        sys.stderr.write("\n"
                         "    FATAL: We could not detect any samples at all.\n"
                         "\n")
        sys.exit(1)
    return sampleDict
