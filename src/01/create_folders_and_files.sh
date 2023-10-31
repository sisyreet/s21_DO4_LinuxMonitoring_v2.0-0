#!/bin/bash

# $1 - это абсолютный путь. 
# $2 - количество вложенных папок. 
# $3 - список букв английского алфавита, используемый в названии папок (не более 7 знаков). 
# $4 - количество файлов в каждой созданной папке. 
# $5 - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). 
# $6 - размер файлов (в килобайтах, но не более 100).

function create_folders
{
	str="$3"
	num_of_folders=$2
	path=$1
	i=1
	while [[ ${#str} -lt 4 ]]
	do
		temp=${str::1}
		temp+=$str
		str=$temp
		i=$((i+1))
	done
	tmp1+=${str:0:$i}
	for (( j = 0; j < $num_of_folders; j++ ))
	do
		if [[ ${#finalname} == 255 ]]; then
			i=$((i+1))
			tmp1=${str:0:$i}
		fi
		if [[ $i > ${#str} ]]; then
			echo "I'm out of possible folder names"
			break
		fi
		tmp2=${str:$i:${#str}}
		tmp1+=${tmp1: -1}
		finalname="$tmp1$tmp2"
		finalname+="_"
		finalname+=$(date +"%d%m%y")
		mkdir $path/$finalname
		echo -e "$path"/"$finalname-------$(date +'%e.%m.%Y')" >> log.txt
		create_files "$path/$finalname" "$4" "$5" "$6"
	done
}

function create_files # $1 folder path, $2 num of files, $3 name, $4 size
{
	path_for_files=$1
	filename=${3%.*}
	ext=${3##*.}
	size=${4:0:${#4}-2}
	y=1
	while [[ ${#filename} -lt 4 ]]
	do
		tempo=${filename::1}
		tempo+=$filename
		filename=$tempo
		y=$((y+1))
	done
	temp1=${filename:0:$y} # if += will continue names in new folder
	for (( k = 0; k < $2; k++ ))
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
		fallocate -l ${size}K $path_for_files/$final_filename
		echo -e "$path_for_files"/"$final_filename-------$(date +'%e.%m.%Y')-------${size}kb" >> log.txt
		freespace=$(df / | grep /$ | awk '{print $4}')
		if [[ ${freespace} -lt 1048776 ]]; then # 1GB + 200 kb
			error_message "Space error"
		fi
	done
}
