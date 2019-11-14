#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <base_dir> <prefix> [--help or -h]

Description:
    Syncs user to environment

Arguments:
    base_dir:       the base directory of the emr to cdp demo
    prefix:         prefix for your assets
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

sleep_duration=1 

# Create groups

cdp environments sync-all-users --environment-name $2-cdp-env