#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <base_dir> <prefix> <credential> <region> <key> [--help or -h]

Description:
    Launches a CDP environment

Arguments:
    base_dir:       the base directory of the emr to cdp demo
    prefix:         prefix for your assets
    credentials:    CDP credential name
    region:         region for your env
    key:            name of the AWS key to re-use
    --help or -h:   displays this help"

}

# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $1 == "--help") ||  $1 == "-h" ]] 
then 
    display_usage
    exit 0
fi 


# Check the numbers of arguments
if [  $# -lt 5 ] 
then 
    echo "Not enough arguments!"
    display_usage
    exit 1
fi 

if [  $# -gt 5 ] 
then 
    echo "Too many arguments!"
    display_usage
    exit 1
fi 


export AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r)

cdp environments create-aws-environment --environment-name $2-cdp-env \
    --credential-name $3 \
    --region $4 \
    --security-access cidr="0.0.0.0/0"  \
    --authentication publicKeyId="$5" \
    --log-storage storageLocationBase="$2-cdp-bucket",instanceProfile="arn:aws:iam::$AWS_ACCOUNT_ID:instance-profile/$2-idbroker-role" \
    --network-cidr "10.0.0.0/16" \
    --s3-guard-table-name $2-cdp-table
