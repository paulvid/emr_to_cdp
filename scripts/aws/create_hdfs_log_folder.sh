#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <host> <base_dir> [--help or -h]

Description:
    Creates a /nifi/ folder to hold spark logs.

Arguments:
    host:     host to connect to
    base_dir: the base directory of the emr to cdp demo
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

if [  $# -gt 2 ] 
then 
    echo "Too many arguments!"
    display_usage
    exit 1
fi 

ssh hadoop@$1 'bash -s' < $2/scripts/aws/hadoop_command.sh