import requests
import sys
import os
from bs4 import BeautifulSoup as bs
import urllib.request


def ikirtan(link, baseLink):
    res = requests.get(link)
    soup = bs(res.text, "html.parser")
    if link[-1] != "/":
        link += "/"

    tables = soup.find_all(
        "table",
        bgcolor="CCCCCC",
        width="80%",
        cellspacing="0",
        cellpadding="4",
        border="0",
    )
    tables += soup.find_all("table", bgcolor="9999CC")
    for item in tables:
        audio = item.find("img", src="index.php?i=a")
        new_link = baseLink + item.find("a")["href"]
        if not audio:
            # only folders are supposed to be in here
            ikirtan(new_link, baseLink)
            continue
        print(new_link)


# ikirtan("https://www.ikirtan.com/index.php?q=f&f=%2F_Bhai_Jeevan_Singh_Jee","https://www.ikirtan.com/")


def goldenKhajana(link):
    res = requests.get(link)
    soup = bs(res.text, "html.parser")
    td = soup.find_all("td", valign="top")
    atags = [i.find("a") for i in td]
    links = []
    names = []
    for i in atags:
        title = "http://sikhsoul.com" + i["href"]
        if title not in links:
            links.append("http://sikhsoul.com" + i["href"])
        if i.text not in names:
            names.append(i.text)
    names = names[1:]
    return names, links


def download(links, path):
    if path[-1] != "\\":
        path += "\\"
    count = 0
    print(len(links))
    print(len(set(links)))
    links = sorted(set(links))
    for i in links:
        count += 1
        title = i.split("/").replace("%20", " ", -1)
        title = f"{count}) {title}"
        whereToPut = f"{path}/{title}"
        try:
            urllib.request.urlretrieve(i, whereToPut)
            print(f"Downloaded: {whereToPut}")
        except Exception as e:
            print(f"No download :{e}")


whereTodl = sys.argv[1] if len(sys.argv[1]) > 1 else "./"
theLink = input("Enter the link: ")
printing = "p" in input("Would you like Print the links or Download? [p/d]: ").lower()
names, links = goldenKhajana(theLink)
if printing:
    [print(i) for i in links]
else:
    if not os.path.isdir(whereTodl):
        os.mkdir(whereTodl)
    download(links, whereTodl)
