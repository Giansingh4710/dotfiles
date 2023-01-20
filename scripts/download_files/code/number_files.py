import os, sys

def printDirs(theDir,theTrackNumber,depth):
    for item_in_dir in os.listdir(theDir):
        print(depth*"  ",end="")
        print(theTrackNumber,item_in_dir,sep=": ")
        theTrackNumber+=1;
        
        fullName = theDir+"/"+ item_in_dir
        if os.path.isdir(fullName):
            depth+=1
            theTrackNumber = printDirs(fullName,theTrackNumber,depth)
            depth-=1

    return theTrackNumber
trackNum = 1
depth = 0
# dir = len(sys.argv)>1 ? sys.argv[1] : "."
dir = sys.argv[1] if len(sys.argv)>1 else "."
printDirs(dir,trackNum,depth)
