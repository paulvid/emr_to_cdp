#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <publicip> <privatednsname> [--help or -h]

Description:
    Adds instances to /etc/hosts.

Arguments:
    publicip:  Public IP of the instance
    privatednsname: Private DNS name of the instances
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


sudo -- sh -c -e "echo '$1  $2' >> /etc/hosts"