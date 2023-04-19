import urllib.request
from selenium import webdriver
import time
import os
import sys


def getKeertanis(keertanis):
    peopleUrl = {}
    for keertani in keertanis:
        br.get("https://www.akj.org/keertan.php")
        br.find_element_by_css_selector("#select2-keert_drpdwn-container").click()
        dropDown = br.find_element_by_css_selector(
            "body > span > span > span.select2-search.select2-search--dropdown > input"
        )
        dropDown.send_keys(keertani)  # send name of keertani to input box

        optCont = br.find_element_by_css_selector("#select2-keert_drpdwn-results")
        optCont = optCont.find_elements_by_tag_name("li")

        optLst = [i.text for i in optCont]
        if optLst[0] == "No results found":
            print(f"{keertani}: not valid input")
            continue
        for i in range(len(optLst)):
            print(f"{i+1}) {optLst[i]}")

        ind = 0
        if len(optLst) > 1:
            # if more than 1 keertani of that name, you can pick which one you want
            ind = int(input("Type the number for the keertani you want: ")) - 1
        theKeertani = optLst[ind]
        print(theKeertani, end="\n\n")
        optCont[ind].click()
        br.find_element_by_css_selector("input.btn").click()  # click search button
        peopleUrl[theKeertani] = br.current_url
    print(peopleUrl)
    return peopleUrl


# this will take in the dictionary generated from the getKeertanis func


def getShabads(keertanis, printing, maxDepth=100, recursed=0):
    print("Finding tracks...")
    keertanTracks = {}
    for keertani in keertanis:
        # the key is the name and the value is the url
        br.get(keertanis[keertani])
        pluses = br.find_elements_by_class_name("fa-plus")
        keertanTracks[keertani] = []
        for plus in pluses:
            plus.click()
            # All this code above in this func is to open all the '+' buttons on the akj website so I can scrape the shabads
            time.sleep(0.2)
        atags = br.find_elements_by_tag_name("a")
        for atag in atags:
            link = atag.get_attribute("href")
            if link != None:
                # there are alot of href links on the site so this basically only adds the keertani file and not the other links
                if "Keertan" in link and "akj" in link and "mp3" in link:
                    keertanTracks[keertani].append(link)
        # on the buttom of the page, if the keetani has more than 1 page of keertani, this will be there
        nextPageUl = br.find_elements_by_class_name("setPaginate")
        if recursed >= (maxDepth - 1):
            continue  # don't want to recurse for all keertan
        if len(nextPageUl) > 0:  # if more than one page
            li = nextPageUl[0].find_elements_by_tag_name("li")
            # so basically the buttom page switcher is a ul tag. The first li tag is to let you know what page your are on like "Page 2 of 4". The last two li tags are "Next" and "Last" buttons
            actualPages = li[2:-2]
            # get all the links for the differt pages of the keertani if they have more than 1
            theLinks = [
                i.find_element_by_tag_name("a").get_attribute("href")
                for i in actualPages
            ]
            for i in theLinks:  # links to the differt pages of the same keerani
                if (
                    None not in theLinks
                ):  # When you are on like page "2 of 5", the second li tag will have no href since you are in that link rn so it will give none. This way in the next iteration when you recurse, it won't keep recusing again because there will be a none in the list. This way it will only recurse once for each page
                    tracksOnOtherPage = getShabads(
                        {keertani: i}, printing, maxDepth, recursed + 1
                    )
                    for track in tracksOnOtherPage[keertani]:
                        if printing:
                            print(track)
                        keertanTracks[keertani].append(track)
    return keertanTracks


def printTracks(shabads):
    for keertani in shabads:
        for track in shabads[keertani]:
            print(track)


def download(keertanis, thePath):
    if thePath[-1] != "/":
        thePath += "/"
    print(thePath)
    for keertani in keertanis:
        counter = 0
        path = thePath + keertani
        print(path)
        os.mkdir(path)
        tracks = keertanis[keertani]
        for ind, track in enumerate(tracks):
            counter += 1
            b = track.split("/")
            title = b[-1][:-1] + "3"
            title = f"{counter}) {title}"
            try:
                urllib.request.urlretrieve(track, f"{path}/{title}")
                print(f"Downloading track {ind+1} of {len(tracks)} - {title}")
            except Exception:
                print(f"Couldn't download: {title}")


argv = sys.argv
whereTodl = argv[1]
keertanis = argv[2:]
print(keertanis)
and = input("Would you like Print the links or Download? [p/d]: ")
printing = "p" in and.lower()
# keertanis=["Bibi Sant Kaur","bhai harsimran singh", "bibi harkiran kaur", "bhai gurbir singh","bibi baljinder kaur", "bhai jagjit singh", "bhai amolak singh","bhai harpreet singh toronto","bhai prabhjot singh delhi","bhai gurinder singh california","bhai davinderbir singh","bhai gursharan singh faridabad","bhai pritpal singh regina", "bhai dilveer singh"]
# keertanis=["Doola","Harpreet Singh Jee (Toronto)","Jagpal Singh"]
options = webdriver.ChromeOptions()
options.headless = True
options.add_argument("--headless")
br = webdriver.Chrome("/Users/gians/Desktop/chromedriver")  # ,options=options)
a = getKeertanis(keertanis)  # {'keetaniName':linkToKeetantracksBykeertani}
# ,pages) #{'keertaniName': [links to all their tracks]}
shabads = getShabads(a, printing)

br.quit()

if not printing:
    if not os.path.isdir(whereTodl):
        os.mkdir(whereTodl)
    download(shabads, whereTodl)
