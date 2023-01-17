#!/bin/bash

function error_message
{
	printf "$1\n"
	exit
}

# Параметр 1 - это абсолютный путь. 
# Параметр 2 - количество вложенных папок. 
# Параметр 3 - список букв английского алфавита, используемый в названии папок (не более 7 знаков). 
# Параметр 4 - количество файлов в каждой созданной папке. 
# Параметр 5 - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). 
# Параметр 6 - размер файлов (в килобайтах, но не более 100).

function check_args
{
	if ! [[ -d $1 && "$1" =~ ^'/' ]] # path exists AND there is a '/' in the begining of line
	then
		error_message "main.sh: Wrong argument #1\nUsage: ./main.sh /home/ 4 biba 7 fuck.you 98kb"
	fi
	if [[ $2 -lt 1 ]] # number of folders is more than zero
	then
		error_message "main.sh: Wrong argument #2\nUsage: ./main.sh /home/ 4 biba 7 fuck.you 98kb"
	fi
	if [[ "$3" =~ [^a-z$] || ${#3} -lt 2 || ${#3} -gt 7 ]] # argument is alphabetic a-z and the number of letters is in the range from 2 to 7 #[^a-zA-Z$]#
	then
		error_message "main.sh: Wrong argument #3\nUsage: ./main.sh /home/ 4 biba 7 fuck.you 98kb"
	fi
	if [[ $4 -lt 1 ]] # check if the number of files greater than 1
	then
		error_message "main.sh: Wrong argument #4\nUsage: ./main.sh /home/ 4 biba 7 fuck.you 98kb"
	fi
	if ! [[ "$5" =~ ^([a-z]{2,7})\.([a-z]{1,3}$) ]] # check filename and extension
	then
		error_message "main.sh: Wrong argument #5\nUsage: ./main.sh /home/ 4 biba 7 fuck.you 98kb"
	fi
	if [[ $6 -lt 1 || $6 -gt 100 ]]; then # check if the number is in the range from 1 to 100
		error_message "main.sh: Wrong argument #6\nUsage: ./main.sh /home/ 4 biba 7 fuck.you 98kb"
	fi
	#add check for "kb"
}
