import requests, os, re, sys
import urllib.request
from bs4 import BeautifulSoup as bs
from datetime import datetime as dt

allKbSum = 0
totalFiles = 0

regExpr = re.compile(r"([0-9]{1,3}(\.[0-9]*)?)\s(KB|MB|GB)")
def getKbFromText(fileObj):
    fileSize = fileObj.find_all("td", align="right")[-1].text
    title = fileObj.find("font", size="2", color="0069c6").text

    multiplier = 1
    number = 0
    sizeType = "kb"

    searchObj = regExpr.search(fileSize)
    if searchObj:
        number = searchObj.group(1)
        sizeType = searchObj.group(3).lower()
    else:
        print(f"No file size for {title}")

    if "mb" == sizeType:
        multiplier = 1000
    elif "gb" == sizeType:
        multiplier = 1_000_000

    """ print(f"{title}: {float(number) * multiplier}") """
    ans = float(number) * multiplier
    global allKbSum
    allKbSum += ans
    return ans


def getAllLinks(url, folderName, printLink, getAllSubDirs):
    res = requests.get(url)
    soup = bs(res.text, "html.parser")
    kathas = soup.find_all("table", cellpadding="4")[4:-2]

    folderWithLinks = {
        folderName: {"metadata": {"size_kb": 0, "folderName": folderName}}
    }
    count = 0
    for fileObj in kathas:
        title = fileObj.find("font", size="2", color="0069c6")
        if title:
            title = title.text
        else:
            continue

        newUrl = "http://www.gurmatveechar.com/" + fileObj.find("a").get("href")
        if "mp3" in newUrl or "MP3" in newUrl:
            count += 1
            kbs = getKbFromText(fileObj)
            folderWithLinks[folderName]["metadata"]["size_kb"] += int(kbs)
            title = f"{str(count).zfill(3)} ) {title}"
            folderWithLinks[folderName][title] = newUrl
            if printLink:
                print(newUrl)
        else:
            newFolder = title
            if not getAllSubDirs:
                dlFolder = input(
                    f"{newFolder}\n Do you want to download this folder? [y/n]: "
                )
                if "n" in dlFolder.lower():
                    continue
            newFolderWithLinks = getAllLinks(
                newUrl, newFolder, printLink, getAllSubDirs
            )
            folderWithLinks[folderName]["metadata"]["size_kb"] += newFolderWithLinks[
                newFolder
            ]["metadata"]["size_kb"]
            folderWithLinks[folderName].update(newFolderWithLinks)
    global totalFiles
    totalFiles += count
    return folderWithLinks


def download(kathasObj, thePath, justPrinting, recursiveDepth=-1):
    for title in kathasObj:
        spaces = "  " * recursiveDepth
        if title == "metadata":
            print(
                f"{spaces}{kathasObj[title]['folderName']}:  {kathasObj[title]['size_kb']/1000} MB"
            )
            continue
        if type(kathasObj[title]) == dict:
            newPath = thePath + title + "/"
            if not justPrinting:
                os.mkdir(newPath)
            download(kathasObj[title], newPath, justPrinting, recursiveDepth + 1)
            continue

        if justPrinting:
            continue
        link = kathasObj[title]
        pathToDl = f"{thePath}{title}.mp3"
        print(f"{spaces}{spaces}{link}")
        urllib.request.urlretrieve(link, pathToDl)
        """ try:         """
        """ except Exception as e: """
        """ print(f"Error: {e}") """
    return


def EnterUrl(link, path, printing, downloadAllSubDirs, folderNameToPutAllFiles):
    start = str(dt.now())
    kathas = getAllLinks(link, folderNameToPutAllFiles, printing, downloadAllSubDirs)

    print("\n")
    download(kathas, path, printing)
    end = str(dt.now())

    print(f"\nTotal MBs: {allKbSum/1000}")
    print(f"Total GBs: {allKbSum/1000000}")
    print("In total: " + str(totalFiles) + " total files\n")

    print(f"Start: {start}")
    print(f"End: {end}", end="\n\n")
    startSeconds = (
        (int(start[11:13]) * 60 * 60) + (int(start[14:16]) * 60) + int(start[17:19])
    )
    endSeconds = (int(end[11:13]) * 60 * 60) + (int(end[14:16]) * 60) + int(end[17:19])
    print(f"Seconds: {endSeconds-startSeconds}")
    print(f"Minutes: {(endSeconds-startSeconds)/60}")
    print(f"Hours: {(endSeconds-startSeconds)/(60*60)}")


path = sys.argv[1]
urls = sys.argv[2:]

printing = (
    "p" in input("Would you like Just print the links or Download? [p/d]: ").lower()
)

subDirsDl = input("Do you want to download ALL Subdirectories? [y/n]: ").lower()
downloadAllSubDirs = "y" in subDirsDl or "a" in subDirsDl


if path[-1] != "/":
    path += "/"

for url in urls:
    url = url.strip()
    title = url.split("%2F")[-1].split("/")[-1]
    EnterUrl(url, path, printing, downloadAllSubDirs, title)
