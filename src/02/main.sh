#!/bin/bash

. check_args.sh
. create_folders_and_files.sh

if [[ $# == 3 ]]
then
	check_args "$1" "$2" "$3"
	create_folders "$1" "$2" "$3"
else
	error_message "main.sh: Usage: ./main.sh flname fname.ext 98Mb"
fi