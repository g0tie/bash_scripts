#!/usr/bin/python

import os

weight = input("Weight: ")
height = input("Height: ") 

if height > 2 or height < 0 :
	print("You must enter your height in meters")
	exit()

if weight < 0 :
	print("Weight cant be 0 or negative value")
	exit()

result = weight / (height * height)

os.system("clear")

print("Your IMC: " + str(round(result, 1))) 
print("\nUnderweight: < 18.5 \nNormal: 18.5 - 24.9 \nOverweight: 25 - 29.9 \nObesity : > 30")
