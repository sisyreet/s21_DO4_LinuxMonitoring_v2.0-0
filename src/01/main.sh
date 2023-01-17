#!/bin/bash

. check_args.sh
. create_folders.sh

if [[ $# == 6 ]]
then
	check_args "$1" "$2" "$3" "$4" "$5" "$6"
	create_folders "$1" "$2" "$3"
else
	error_message "Error!"
fi