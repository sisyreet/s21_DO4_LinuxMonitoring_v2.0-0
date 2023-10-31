#!/bin/bash

function create_folders # $1 flname, $2 fname.ext $3 size
{
	touch log.txt
	local flname=$1
	local fname=$2
	local size=$3
	local regex_sbin='(/bin/|/sbin/|/bin$|/sbin$)'
	local array=($(find / -type d 2>/dev/null))
	local flpath=${array[$(shuf -i 0-${#array[@]} -n 1)]}
	local i=1
	while [[ ${#flname} -lt 5 ]]
	do
		temp=${flname::1}
		temp+=$flname
		flname=$temp
		i=$((i+1))
	done
	local temp1+=${flname:0:$i}
	while :
	do
		num_of_folders=$(shuf -i 1-100 -n 1)
		flpath=${array[$(shuf -i 0-$((${#array[@]}-1)) -n 1)]}
		if [[ $flpath =~ $regex_sbin ]]; then
			continue
		fi
		for (( j = 0; j < $num_of_folders; j++ ))
		do
			if [[ ${#finalname} == 255 ]]; then
				i=$((i+1))
				temp1=${flname:0:$i}
			fi
			if [[ $i > ${#flname} ]]; then
				echo "I'm out of possible folder names"
				break
			fi
			local temp2=${flname:$i:${#flname}}e
			temp1+=${temp1: -1}
			finalname="$temp1$temp2"
			finalname+="_"
			finalname+=$(date +"%d%m%y")
			if ! [[ $(mkdir -v $flpath/$finalname 2>/dev/null) ]]; then
				echo "oi"
				echo $flpath/$finalname
				break
			fi
			echo -e "$flpath"/"$finalname-------$(date +'%e.%m.%Y')" >> log.txt
			create_files "$flpath/$finalname" "$fname" "$size"
		done
	done
}

function create_files # $1 folder path, $2 fname, $3 size
{
	local path_for_files=$1
	local filename=${2%.*}
	local ext=${2##*.}
	local fsize=${3:0:${#3}-2}
	local num_of_files=$(shuf -i 1-1000 -n 1)
	local y=1
	while [[ ${#filename} -lt 4 ]]
	do
		local temp=${filename::1}
		temp+=$filename
		filename=$temp
		y=$((y+1))
	done
	temp1=${filename:0:$y} # if += will continue names in new folder
	for (( k = 0; k < $num_of_files; k++ ))
	do
		if [[ ${#final_filename} == 255 ]]; then
			y=$((y+1))
			temp1=${filename:0:$y}
		fi
		if [[ $y > ${#filename} ]]; then
			echo "I'm out of possible file names"
			break
		fi
		temp2=${filename:$y:${#filename}}
		temp1+=${temp1: -1}
		final_filename="$temp1$temp2"
		final_filename+="_$(date +"%d%m%y")"
		final_filename+="."
		final_filename+=$ext
		touch $path_for_files/$final_filename
		fallocate -l ${fsize}M $path_for_files/$final_filename
		echo -e "$path_for_files"/"$final_filename-------$(date +'%e.%m.%Y')-------${fsize}Mb" >> log.txt
		freespace=$(df / | grep /$ | awk '{print $4}')
		if [[ ${freespace} -lt 1150976 ]]; then # 1GB + 100 Mb
			error_message "Space error"
		fi
	done
}
