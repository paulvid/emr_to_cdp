#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <host> <file> [--help or -h]

Description:
    Loads a note to zeppelin notebook.

Arguments:
    host:    host running zeppelin
    file:    path to your note
    --help or -h:   displays this help"

}

# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $1 == "--help") ||  $1 == "-h" ]] 
then 
    display_usage
    exit 0
fi 


# Check the numbers of arguments
if [  $# -lt 2 ] 
then 
    echo "Not enough arguments!"
    display_usage
    exit 1
fi 

if [  $# -gt 3 ] 
then 
    echo "Too many arguments!"
    display_usage
    exit 1
fi 

curl -X POST \
  http://$1:8890/api/notebook \
  -H 'Accept: */*' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: text/plain' \
  -d @"$2"