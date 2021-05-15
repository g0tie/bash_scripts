#!/bin/bash
shopt -s extglob # turn on globbing
IFS=$'\n' #indicate to consider new field when line jump, not whitespace

cd $1 || cd $2

files=($(ls -1 -p -d !(*.*))) # -1 display 1 per line, -d list directories not recursively, 

for file in ${files[@]}
do
    isText=$(file $file | grep -o text)
    isAudio=$(file $file | grep -o audio)
    isImage=$(file $file | grep -o image)

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

    if [[ $isImage == "image" ]]
    then
        isJpeg=$(file $file | grep -o -i "JPEG")
        isPng=$(file $file | grep -o -i "PNG")
        isSvg=$(file $file | grep -o -i "SVG")
        
        [[ $isJpeg == "JPEG" ]] && mv $file $file.jpg
        [[ $isPng == "PNG" ]] && mv $file $file.png
        [[ $isSvg == "SVG" ]] && mv $file $file.svg
    fi

done
