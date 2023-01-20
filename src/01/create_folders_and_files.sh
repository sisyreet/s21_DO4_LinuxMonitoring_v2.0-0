#!/bin/bash

function create_folders # $1 path, $2 num of folders, $3 name
{
	dir_name="$3"
	name_len=${#3}
	i=3
	touch log.txt
	start_name=$3
	
	for (( number=0; number < $2; number++ ))
	do
		if [[ ${#dir_name} -lt 4 ]]; then # if name < 4, multiply 1st char to len of 4
			if [[ ${#dir_name} -lt 3 ]]; then
				start_name=${dir_name::1}
				start_name+=$dir_name
				dir_name=$start_name
			fi
			start_name=${dir_name::1}
			start_name+=$dir_name
			dir_name=$start_name
		fi
		if [[ ${#final_name} -gt 240 ]]; then # dotodo
			echo STOP
			exit
		fi
		dir_name+=${dir_name: -1}
		final_name=$dir_name
		final_name+="_"
		final_name+=$(date +"%d%m%y")
		mkdir $1/$final_name
		echo -e "$path"/"-------$(date +'%e.%m.%Y')" >> log.txt
		create_files "$1/$final_name" "$4" "$5" "$6"
	done
}

function create_files # $1 folder path, $2 num of files, $3 name, $4 size
{
	path=$1
	filename=${3%.*}
	ext=${3##*.}
	start_char=$3
	size=${4:0:${#4}-2}

	for (( j=0; j < $2; j++ ))
	do
		if [[ ${#filename} -lt 4 ]]; then
			if [[ ${#filename} -lt 3 ]]; then
			
				start_char=${filename::1}
				start_char+=$filename
				filename=$start_char
			fi
			start_char=${filename::1}
			start_char+=$filename
			filename=$start_char
		fi
		filename+=${filename: -1}
		final_filename=$filename
		final_filename+="."
		final_filename+=$ext
		touch $path/$final_filename
		fallocate -l ${size}K $path/$final_filename
		echo -e "$path"/"$final_filename-------$(date +'%e.%m.%Y')-------${size}kb" >> log.txt
		freespace=$(df / | grep /$ | awk '{print $4}')
		if [[ ${freespace} -lt 1048576 ]]; then
			error_message "Space error"
		fi
	done
}
