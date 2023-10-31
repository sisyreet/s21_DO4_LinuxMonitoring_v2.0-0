#!/bin/bash

function check_log_path # $1 path to logfile
{
	# /home/kos/21school/DO4_LinuxMonitoring_v2.0-0/src/02/log.txt
	regex_folder='_(0[1-9]|[1-2][0-9]|3[0-1])(0[1-9]|1[0-2])[0-9]{2}[-]'
	regex_file='_(0[1-9]|[1-2][0-9]|3[0-1])(0[1-9]|1[0-2])[0-9]{2}\.[a-z]+'
	path_to_delete=""
	path=$1

	while IFS= read -r line
	do
		if [[ $line =~ $regex_folder ]]; then
			path_to_delete=$(echo $line | grep -Po '.{1,}'$regex_folder)
			if [[ -d ${path_to_delete::-1} ]]; then
				echo "Deleting directory ${path_to_delete::-1}"
				rm -rf ${path_to_delete::-1}
			fi
		fi
		if [[ $line =~ $regex_file ]]; then
			path_to_delete=$(echo $line | grep -Po '.{1,}'$regex_file)
			if [[ -f $path_to_delete ]]; then
				echo "Deleting file $path_to_delete"
				rm -rf $path_to_delete
			fi
		fi
	done < "$path"
}

function check_mask # $1 mask
{
	mask=$1
	count=0
	regex_folder_mask='_(0[1-9]|[1-2][0-9]|3[0-1])(0[1-9]|1[0-2])[0-9]{2}$'
	regex_file_mask='_(0[1-9]|[1-2][0-9]|3[0-1])(0[1-9]|1[0-2])[0-9]{2}\.[a-z]+'
	if ! [[ $mask =~ $regex_folder_mask ]]; then
		echo oi
	fi
	paths_array=($(find / 2>/dev/null))
	for i in "${paths_array[@]}"
	do
		if [[ ($i =~ $regex_file_mask && $i =~ $mask) || ($i =~ $regex_folder_mask && $i =~ $mask) ]]; then
			echo "deleting... $i"
			rm -rf $i
			count=$((count+=1))
		fi
	done
	echo "deleted $count files"
}

function check_dnt
{
	#asd
}
