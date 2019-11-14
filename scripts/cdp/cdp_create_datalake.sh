#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <base_dir> <prefix> [--help or -h]

Description:
    Creates a data lake post environment creation

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

export AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r)

cdp datalake create-aws-datalake --datalake-name $2-cdp-dl \
    --environment-name $2-cdp-env \
    --cloud-provider-configuration instanceProfile="arn:aws:iam::$AWS_ACCOUNT_ID:instance-profile/$2-idbroker-role",storageBucketLocation="s3a://$2-cdp-bucket/$2-dl" 
