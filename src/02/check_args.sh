#!/bin/bash

function error_message
{
	printf "$1\n"
	exit
}

# Параметр 1 - список букв английского алфавита, используемый в названии папок (не более 7 знаков). 
# Параметр 2 - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). 
# Параметр 3 - размер файла (в Мегабайтах, но не более 100).

function check_args
{
	if [[ "$1" =~ [^a-z$] || ${#1} -lt 2 || ${#1} -gt 7 ]] # argument is alphabetic a-z and the number of letters is in the range from 2 to 7 #[^a-zA-Z$]#
	then
		error_message "main.sh: Wrong argument #1\nUsage: ./main.sh biba fuck.off 98Mb"
	fi
	if ! [[ "$2" =~ ^([a-z]{2,7})\.([a-z]{1,3}$) ]] # check filename and extension
	then
		error_message "main.sh: Wrong argument #2\nUsage: ./main.sh biba fuck.off 98Mb"
	fi
	num=${3:0:${#3}-2}		# split the argument on number 
	word=${3:${#3}-2:${#3}}	# and the rest
	if ! [[ $num =~ ^[0-9]+$ ]]; then # check if the num is a num
		error_message "main.sh: Wrong argument #3\nUsage: ./main.sh biba fuck.off 98Mb"
	fi
	if [[ $num -lt 1 || $num -gt 100 || $word != "Mb" ]]; then # check if the number is in the range from 1 to 100 AND has a 'kb' at the end
		error_message "main.sh: Wrong argument #3\nUsage: ./main.sh biba fuck.off 98Mb"
	fi
}

	
