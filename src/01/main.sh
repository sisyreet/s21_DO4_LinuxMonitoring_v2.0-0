#!/bin/bash

. check_args.sh
. create_folders_and_files.sh

# absolute_path=$1
# num_of_folders=$2
# folders_names=$3

if [[ $# == 6 ]]
then
	check_args "$1" "$2" "$3" "$4" "$5" "$6"
	create_folders "$1" "$2" "$3" "$4" "$5" "$6"
else
	error_message "Error!"
fi
