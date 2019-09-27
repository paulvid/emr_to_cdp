#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <bucket> <base_dir> [--help or -h]

Description:
    Creates the worldwidebank database

Arguments:
    bucket:   location of the worldwidebank data
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

sed -i.bak "s|__mybucket__|$1|g" $2/scripts/aws/create_hive_db.sql

cat $2/scripts/aws/create_hive_db.sql
