import os, sys

def printDirs(theDir,theTrackNumber=0,depth=0):
    if os.path.split(theDir)[-1][0] == ".":
        return theTrackNumber

    try:
        list_dirs = os.listdir(theDir)
    except Exception as e:
        print("Error: ",e)
        return theTrackNumber

    for item_in_dir in list_dirs:
        fullName = theDir+"/"+ item_in_dir
        if os.path.isdir(fullName):
            print(depth*"  ",end="")
            print(theTrackNumber +1,item_in_dir,sep=": ")
            depth+=1
            theTrackNumber = printDirs(fullName,theTrackNumber,depth)
            depth-=1
        else: #is file
            theTrackNumber+=1;
            print(depth*"  ",end="")
            print(theTrackNumber,item_in_dir,sep=": ")
    return theTrackNumber

dir = sys.argv[1]
printDirs(dir)
