import urllib.request
from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import os
import sys


def getKeertanis(keertanis: list[str]) -> dict[str, str]:
    peopleUrl = {}
    for keertani in keertanis:
        br.get("https://www.akj.org/keertan.php")
        br.find_element(By.CSS_SELECTOR, "#select2-keert_drpdwn-container").click()
        dropDown = br.find_element(
            By.CSS_SELECTOR,
            "body > span > span > span.select2-search.select2-search--dropdown > input",
        )
        dropDown.send_keys(keertani)  # send name of keertani to input box
        optCont = br.find_element(
            By.CSS_SELECTOR, "#select2-keert_drpdwn-results"
        ).find_elements(By.TAG_NAME, "li")

        if optCont[0] == "No results found":
            print(f"{keertani}: not valid input")

        for i in range(len(optCont)):
            print(f"{i+1}) {optCont[i].text}")

        ind = 0
        if len(optCont) > 1:
            ind = int(input("Type the number for the keertani you want: ")) - 1

        theKeertani = optCont[ind].text
        print(theKeertani, end="\n\n")
        optCont[ind].click()
        br.find_element(By.CSS_SELECTOR, "input.btn").click()
        peopleUrl[theKeertani] = br.current_url
    return peopleUrl


def getShabads(keertanis_dict: dict[str, str], printing: bool) -> dict[str, list[str]]:
    print("Finding tracks...")
    keertanTracks = {}
    for person in keertanis_dict:
        br.get(keertanis_dict[person])
        pluses = br.find_elements(By.CLASS_NAME, "fa-plus")
        keertanTracks[person] = []
        for plus in pluses:
            plus.click()
            time.sleep(0.2)

        atags = br.find_elements(By.TAG_NAME, "a")
        for atag in atags:
            link = atag.get_attribute("href")
            if link != None and "Keertan" in link and "akj" in link and "mp3" in link:
                keertanTracks[person].append(link)
                if printing:
                    print(link)
        # if len(keertanTracks) > 1000: break
        # on the buttom, if the keetani has more than 1 page of keertan
        nextPageUl = br.find_elements(By.CLASS_NAME, "setPaginate")
        li = nextPageUl[0].find_elements(By.TAG_NAME, "li")[:-2] #last 2 are next and last
        currentAlreadyPageSeen = False #we are on the page where href is None 
        for i in li:
            try:
                href = i.find_element(By.TAG_NAME, "a").get_attribute("href")
            except Exception as e:
                # print(e)
                continue

            if href == None:
                currentAlreadyPageSeen = True
                continue
            if currentAlreadyPageSeen:
                othrPageTrks = getShabads({person: href}, printing)
                for track in othrPageTrks[person]:
                    keertanTracks[person].append(track)
    return keertanTracks

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
printing = "p" in input("Would you like Print the links or Download? [p/d]: ").lower()

br = webdriver.Firefox()
# keertanis=["Bibi Sant Kaur","bhai harsimran singh", "bibi harkiran kaur", "bhai gurbir singh","bibi baljinder kaur", "bhai jagjit singh", "bhai amolak singh","bhai harpreet singh toronto","bhai prabhjot singh delhi","bhai gurinder singh california","bhai davinderbir singh","bhai gursharan singh faridabad","bhai pritpal singh regina", "bhai dilveer singh"]
peoples_to_url_dict = getKeertanis(keertanis)
shabads = getShabads(peoples_to_url_dict, printing)

br.quit()

if not printing:
    if not os.path.isdir(whereTodl):
        os.mkdir(whereTodl)
    download(shabads, whereTodl)

