#!/bin/bash

function create_folders # $1 path, $2 num of folders, $3 name
{
	for i in {1..50}
	do
		dir_name="$3"
		dir_name+=$i
		dir_name+="_"
		dir_name+=$(date +"%d%m%y")
		mkdir $1/ $dir_name
	done
}

# function create_files
# {

# }