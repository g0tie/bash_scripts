#!/bin/bash
shopt -s extglob # turn on globbing
tosort_folder=$1

pushd $tosort_folder &> /dev/null

doc_ext=("pdf" "odt" "txt" "html" "js" "css" "csv" "sql" "php" "xml" "ini" "sh" "docx" "java" "class" "py")
img_ext=("png" "jpg" "svg" "webp" "jpeg")
vid_ext=("mp4" "avi" "mov")
audio_ext=("mp3" "ogg" "wav")

function move_files() {

    destination=$1
    file_ext=${@:2} #get all elements of array starting at index 2

    for ext in $file_ext
    do
        file_count=`ls *.$ext 2> /dev/null | wc -l` #count nb of element to verify ther are files
        if [ $file_count != 0 ]; then
            mv *.$ext $destination
        else 
            continue #if no file with extensiosn go to next extension
        fi
    done

    echo "Your files has been successfully moved to $destination"
}

move_files "$HOME/Documents" ${doc_ext[@]}
move_files "$HOME/Pictures" ${img_ext[@]}
move_files "$HOME/Videos" ${vid_ext[@]}
move_files "$HOME/Music" ${audio_ext[@]}

popd &> /dev/null

