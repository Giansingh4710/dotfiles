from selenium import webdriver
import time
import os
import sys
from bs4 import BeautifulSoup as bs
import subprocess


def download_link(link):
    print(f"yt-dlp '{link}'")
    subprocess.run(["yt-dlp", link, "-o", "%(playlist_index)s) %(title)s.%(ext)s"])


def scroll_to_end_of_page(br):
    scroll = 0
    end = False
    while not end:
        firstScroll = br.execute_script(
            "window.scrollTo(0, document.body.scrollHeight);var lenOfPage=document.body.scrollHeight;return lenOfPage;"
        )
        time.sleep(3)
        if firstScroll == scroll:
            end = True
        else:
            scroll = firstScroll


def linksToPlayLists(url) -> dict[str, str]:
    br = webdriver.Firefox()
    br.get(url)
    scroll_to_end_of_page(br)
    content = br.page_source.encode("utf-8").strip()
    soup = bs(content, "lxml")
    allPlaylists = soup.find("div", class_="userMain__content").find_all(
        "li", class_="soundList__item"
    )

    playlistLinks = {}
    for playlist in allPlaylists:
        atag = playlist.find("a", class_="soundTitle__title")
        playlistLinks[atag.text.strip()] = "https://soundcloud.com" + atag["href"]
    br.close()
    return playlistLinks


def download_playlist_yt_dlp(playlists):
    for playlist in playlists:
        os.mkdir(playlist)
        os.chdir(playlist)
        url = playlists[playlist]
        download_link(url)
        os.chdir("..")


def main(link):
    lst = link.split('?')[0].split("/")
    if lst[-1] == "":
        lst.pop()

    if lst[-1] == "sets":
        playlistDict = linksToPlayLists(link)
        download_playlist_yt_dlp(playlistDict)
    else:
        subprocess.run(["yt-dlp", link])


playlistDict = {
    "Sri Guru Angad Dev Ji Katha": "https://soundcloud.com/gianishersinghjiambala/sets/sri-guru-angad-dev-ji-katha",
    "Sri Guru Granth Sahib Ji Katha": "https://soundcloud.com/gianishersinghjiambala/sets/sri-guru-granth-sahib-ji-katha",
}

# yt-dlp --extract-audio --audio-format mp3 "$link"

# whereTodl = sys.argv[1] if len(sys.argv[1]) > 1 else "./"
link = input("Enter the link: ")
main(link)
