#!/bin/bash
shopt -s extglob # turn on globbing
IFS=$'\n' #indicate to consider new field when line jump, not whitespace

cd $1 || cd $2

files=($(ls -1 -p -d !(*.*))) # -1 display 1 per line, -d list directories not recursively, 

for file in ${files[@]}
do
    isText=$(file $file | grep -o text)
    isAudio=$(file $file | grep -o audio)

    if [[ $isText == "text" ]]
    then
        mv $file $file.txt
    fi

    if [[ $isAudio == "audio" ]]
    then
       
        isMp3=$(file $file | grep -o -i "MPEG")
        isOgg=$(file $file | grep -o -i "Ogg")
        isAac=$(file $file | grep -o -i "AAC")
        
        [[ $isMp3 == "MPEG" ]] && mv $file $file.mp3
        [[ $isOgg == "Ogg" ]] && mv $file $file.ogg
        [[ $isAac == "AAC" ]] && mv $file $file.aac
    fi

done
