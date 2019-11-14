#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <base_dir> <prefix> [--help or -h]

Description:
    Purges roles and policies for minimal env setup

Arguments:
    base_dir: the base directory of the emr to cdp demo
    prefix:   prefix for your buckets and roles
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

export AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r)

echo "Deleting Roles"
aws iam delete-role --role-name $2-idbroker-role
aws iam delete-role --role-name $2-datalake-admin-role
aws iam delete-role --role-name $2-log-role
aws iam delete-role --role-name $2-ranger-audit-role


echo "Deleting Policies"
aws iam delete-policy --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-idbroker-assume-role-policy
aws iam delete-policy --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-log-policy-s3access
aws iam delete-policy --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-ranger-audit-policy-s3access 
aws iam delete-policy --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-datalake-admin-policy-s3access 
aws iam delete-policy --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-bucket-policy-s3access
aws iam delete-policy --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-dynamodb-policy

echo "Roles and Policies purged!"