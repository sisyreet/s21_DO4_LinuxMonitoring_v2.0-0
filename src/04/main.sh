#!/bin/bash

function get_random {
    echo $(( ( RANDOM % $1 )  + $2 ))
}

function get_agent {
	local agents=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")
  echo "${agents[$(get_random 8 0)]}"
}

# function get_url {

# }

# function get_date {

# }

function get_method {
	local methods=("GET" "POST" "PUT" "PATCH" "DELETE")
  echo "${methods[$(get_random 5 0)]}"
}

function get_response_code {
	local codes=("200" "201" "400" "401" "403" "404" "500" "501" "502" "503")
  echo "${codes[$(get_random 10 0)]}"
}

function get_ip
{
	local ip=""

	for (( i=0; i < 4; i++ ))
	do
	if [[ i==0 ]]; then
		ip+="$(get_random 243 10)"
	else
		ip+="$(get_random 254 1)"
	fi
	if [[ i -ne 3 ]]; then
		ip+='.'
	fi
	done
	echo $ip
}

function main {
	# for (( i=0; i < 1000; i++ ))
	# do
	# 	local ip=""
	# 	ip=$( generate_ip )
	# 	echo $ip
	# done
	for (( i=0; i < 1000; i++ ))
	do
		local ip=""
		ip=$( get_agent )
		echo $ip
		sleep .01
	done
	
	# response_code
}

main