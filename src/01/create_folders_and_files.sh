#!/bin/bash

function create_folders # $1 path, $2 num of folders, $3 name
{
	dir_name="$3"

	touch log.txt
	for (( number=0; number < $2; number++ ))
	do
		last_char=${dir_name: -1} #takes last char
		dir_name+=$last_char
		final_name=$dir_name
		final_name+="_"
		final_name+=$(date +"%d%m%y")
		mkdir $1/$final_name
		create_files "$1/$final_name" "$4" "$5" "$6"
	done
}

function create_files # $1 folder path, $2 num of files, $3 name, $4 size
{
	path=$1
	filename=${3%.*}
	ext=${3##*.}

	echo df / | grep Mem
	# do check for availiable space on /
	for (( i=0; i < $2; i++ ))
	do
		last_char=${filename: -1}
		filename+=$last_char
		final_filename=$filename
		final_filename+="."
		final_filename+=$ext
		touch $path/$final_filename
		truncate -s ${4}K $path/$final_filename
		echo -e "$path"/"$final_filename\t\t$(date +'%e.%m.%Y')\t$4kb" >> log.txt
	done
}