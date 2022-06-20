#!/bin/bash
shopt -s extglob # turn on globbing
tosort_folder=$1

function Main() {

echo "Starting..."
pushd $tosort_folder &> /dev/null

#declare associative array
declare -A extensions 

extensions[doc]=$(ls $(sed 's/\</\*\./g' <<< "pdf odt txt html js css csv sql php xml ini sh docx java class py ai fig drawio cbr ppt json") 2> /dev/null)
extensions[img]=$(ls $(sed 's/\</\*\./g' <<< "png jpg svg webp jpeg") 2> /dev/null)
extensions[videos]=$(ls $(sed 's/\</\*\./g' <<< "mp4 avi mov") 2> /dev/null)
extensions[audio]=$(ls $(sed 's/\</\*\./g' <<< "mp3 ogg wav aac") 2> /dev/null)
extensions[archives]=$(ls $(sed 's/\</\*\./g' <<< "zip rar tar tar.gz tar.xz deb rpm apk iso tgz jar vsix AppImage") 2> /dev/null)

folders=("Documents" "Images" "Videos" "Audios" "Archives")

#Create appropriate folders if no exists
mkdir -p ${folders[@]}

moveFiles

popd &> /dev/null
echo "Files moved"
ls -lh
}

function moveFiles() {
	
    for index in "${!extensions[@]}"
    do
	   case $index in
	   doc)
		destination=${folders[0]}
		;;
	   img)
	   	destination=${folders[1]}
	   	;;
	   videos)
		destination=${folders[2]}
		;;
	   audio)
		destination=${folders[3]}
	   	;;
	   archives)
		destination=${folders[4]}
	   esac
	   
 	   if [ ${#extensions[$index]} -gt 0 ] #check string lenght

	   	mv ${extensions[$index]} $destination  
	   fi 
    done

}

Main
