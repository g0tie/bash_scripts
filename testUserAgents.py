#!/usr/bin/env python3

import sys
import requests

file = open(sys.argv[2], 'r')
url = sys.argv[1]
useragentlist = [line.replace("\n", "") for line in file.readlines()]

def usage():
    print("Usage: python3 testUserAgent.py http://<url> <useragentlist>")
    print("Valid user agent list must be separated by new line")
    print("Do not forget http:// or https:// for valid urls")

try: 
    for index in range(len(useragentlist)):
        headers = {
            'User-Agent' : useragentlist[index],
        }
        
        print("User agent {0} - {1}".format(index, useragentlist[index]) )
        print( requests.get(url, headers = headers ).text )
except:
    usage()


