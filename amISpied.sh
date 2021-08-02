#!/bin/bash

isMicUsed=$(grep owner_pid /proc/asound/card*/pcm*/sub*/status)
isCamUsed=$(lsof /dev/video*)


function killmicrocesses {
echo ""
echo "Would you like to kill all those processes ? (y/n) "
read answer

micPids=($(grep -E owner_pid /proc/asound/card*/pcm*/sub*/status | cut -d":" -f3 | tr -s " "))

if [[ "$answer" == "y" || "$answer" == "Y" ]]
then
	for pid in "${micPids[@]}" 
	do
		kill $pid
	done
fi
}

function killcamprocesses {
echo ""
echo "Would you like to kill all those processes ? (y/n) "
read answer

camPids=($(lsof /dev/video* | cut -d' ' -f3 | uniq | sed '/^[[:space:]]*$/d' ))

if [[ "$answer" == "y" || "$answer" == "Y" ]]
then
	for pid in "${camPids[@]}" 
	do
		kill $pid
	done
fi
}

if [ -z "$isMicUsed" ]
then
	echo "Microphone isn't used"
else
	echo "Microphone is used"
	echo "-----------------"
	echo "$isMicUsed"
	killmicrocesses
fi

if [ -z "$isCamUsed" ]
then
	echo "Camera isn't used"
else
	echo "Camera is used"
	echo "-----------------"
	echo "$isCamUsed"
	killcamprocesses
fi

