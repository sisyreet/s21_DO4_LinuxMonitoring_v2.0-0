#!/bin/bash

. delete.sh
. checks.sh

function dialog
{
	echo -e "\n\033[1;31mWelcome to ERASER-2000! We clean your mess!\033[0m"
	echo "-------------------------------------------"
	while :
	do
		echo -e "Choose how you want to \033[1;31mERASE\033[0m files... Input \"logfile\", \"dnt\" for date'n'time parameter or \"mask\" to \033[1;31mERASE\033[0m files by mask:"
		read answer
		if [[ $answer == "logfile" ]]; then
			echo "input valid path to log file:"
			read path
			if [[ -f $path ]]; then
				check_log_path "$path"
				break
			else
				echo "Invalid input, try again. Type \"exit\" if you bored."
				sleep 1
			fi
		elif [[ $answer == "dnt" ]]; then
			echo "input time in DD-MM-YYYY HH-MM-SS format"
			read datetime
			check_dnt "$datetime"
			break
		elif [[ $answer == "mask" ]]; then
			echo "input mask, e.g \"_230123\"" # do check for format of mask
			read mask
			check_mask "$mask"
			break
		elif [[ $answer == "exit" ]]; then
			echo "Goodbye! :]"
			exit 1
		else
			echo "Invalid input, try again. Type \"exit\" if you bored."
			sleep 1
		fi
	done
}

# delete_by_log
dialog