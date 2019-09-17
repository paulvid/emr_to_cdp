#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <file> <base_dir> [--help or -h]

Description:
    Comments out core-site.xml codec requirements.

Arguments:
    file:     path to your core-site.xml
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

cp $1 $1.old
python3 $2/scripts/aws/comment_core_site.py $1 > tmp_codec.xml

mv tmp_codec.xml $1

