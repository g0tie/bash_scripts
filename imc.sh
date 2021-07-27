#!/bin/bash

weight=$1
height=$2

if [ "$height" -gt 2 || "$height" -lt 0 ]
then
	echo "You must enter your height in meters"
	exit 1
fi

if [ "$weight" -lt 0 ]
then
	echo "Weight cant be 0 || negative value"
	exit 1
fi

result=$(echo "scale=1;$weight / ($height * $height)" | bc -l)

clear

echo "Your IMC: $result" 
echo ""
echo "Underweight: < 18.5"
echo "Normmal: 18.5 - 24.9" 
echo "Overweight: 25 - 29.9" 
echo "Obesity : > 30"
