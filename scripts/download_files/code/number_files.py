import os, sys

def printDirs(theDir,theTrackNumber=0,depth=0):
    for item_in_dir in os.listdir(theDir):
        fullName = theDir+"/"+ item_in_dir
        if os.path.isdir(fullName):
            print(depth*"  ",end="")
            print(theTrackNumber,item_in_dir,sep=": ")
            depth+=1
            theTrackNumber = printDirs(fullName,theTrackNumber,depth)
            depth-=1
        else: #is file
            theTrackNumber+=1;
            print(depth*"  ",end="")
            print(theTrackNumber,item_in_dir,sep=": ")
        

    return theTrackNumber
# dir = len(sys.argv)>1 ? sys.argv[1] : "."
dir = sys.argv[1] if len(sys.argv)>1 else "."
printDirs(dir)
