from bs4 import BeautifulSoup as bs
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import sys
	
base_url = "https://www.pagesjaunes.fr/pros/"
user_url = sys.argv[1]
full_url = base_url + user_url

options = Options();
options.headless = True
options.binary_location = "/usr/bin/chromium-browser"
options.add_argument("--disable-dev-shm-using") 
options.add_argument("start-maximized")
options.add_argument("--window-size=1920,1080")
options.add_argument("--enable-precise-memory-info")
options.add_argument("--disable-popup-blocking")
options.add_argument("--disable-default-apps")
options.add_argument("--incognito")
options.add_argument("--no-sandbox")
options.add_argument("--remote-debugging-port=3001") 

driver = webdriver.Chrome(options=options)
driver.get(full_url)
html = driver.page_source
driver.quit()

soup = bs(html, "html.parser")

target = {
    "name" : soup.find("div", attrs={"class": "denom"}).findChildren("h1", recursive=False)[0].text,
    "description" : soup.find("span", attrs={"class": "activite"}).text,
    "number" : soup.find("span", attrs={"class": "coord-numero"}).text,
    "address" : soup.find("div", attrs={"class": "address-container"}).findChildren("a", recursive=False)[0].text,
    "website" : soup.find("span", attrs={"class": "icon icon-lien"}).find_next_sibling("span").text
}


print("################### WEB SCRAPPING SCRIPT v0.1 #######################\n")

for key, value in target.items():
    print(key.capitalize() + " : " + value)

print("\n#####################################################################")

