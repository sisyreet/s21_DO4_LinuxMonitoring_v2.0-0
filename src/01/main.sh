#!/bin/bash

. check_args.sh
. create_folders_and_files.sh

if [[ $# == 6 ]]
then
	check_args "$1" "$2" "$3" "$4" "$5" "$6"
	create_folders "$1" "$2" "$3" "$4" "$5" "$6"
else
	error_message "main.sh: Usage: ./main.sh /home/ 4 flname 7 fname.ext 98kb"
fi