# Youtube Tendance scrapper v0.1
# g0tie
# github.com/g0tie


from bs4 import BeautifulSoup as bs
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options

import sys
import time
import re

config = {
    "headless" : True,
    "binary_location": "/usr/bin/google-chrome",
    "yt_url":"https://m.youtube.com/feed/explore"
}

config["options"] = [
    "--no-sandbox",
    "--remote-debugging-port=3001",
    "--incognito",
    "--disable-default-apps",
    "--disable-popup-blocking",
    "--enable-precise-memory-info",
    "--window-size=1920,1080",
    "start-maximized",
    "--disable-dev-shm-using",
    "--lang=fr",
    "user-agent=Mozilla/5.0 (Linux; Android 12; M2007J1SC) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.48 Mobile Safari/537.36"
]

def configureDriver(config):
    options = Options()
    options.headless = config["headless"]
    options.binary_location = config["binary_location"]
    
    for conf in config["options"]:
        options.add_argument(conf)

    driver = webdriver.Chrome(options = options)
    driver.get(config["yt_url"])
    driver.find_element(By.CSS_SELECTOR, 'button').click()

    return driver


def getTrendList():
    driver = configureDriver(config)
    html = driver.page_source
    driver.quit()

    # Removing javascript to avoid redirection
    newHtml = re.sub(r"<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>", '', html)
    soup = bs(newHtml, "html.parser")

    return soup.select('div.media-item-metadata>a')


def render():
    trend_list = getTrendList()

    for key in range( 0, len(trend_list)) :
        # get all text from div and make an array by sperating datas elements then if too long shorten the sentence

        title = checkStrLength( trend_list[key].find("h3", class_="media-item-headline").getText(), 20)
        metadatas = trend_list[key].find_all("span", class_="ytm-badge-and-byline-item-byline")

        print(str(key) + " | " + checkStrLength( metadatas[0].getText(), 10) + " | " +  metadatas[1].getText() + " | " + title + " | " +  metadatas[2].getText())

def checkStrLength(str, length):
    if (len(str) > length):
        return str[:length:] + "..."
    else:
        return str

render()