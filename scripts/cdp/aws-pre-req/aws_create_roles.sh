#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <base_dir> <prefix> <bucket> [--help or -h]

Description:
    Creates minimal set of roles for CDP env

Arguments:
    base_dir: the base directory of the emr to cdp demo
    prefix:   prefix for your roles
    bucket:   name of your bucket
    --help or -h:   displays this help"

}

# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $1 == "--help") ||  $1 == "-h" ]] 
then 
    display_usage
    exit 0
fi 


# Check the numbers of arguments
if [  $# -lt 3 ] 
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


export AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r)
export DATALAKE_BUCKET=$3
export STORAGE_LOCATION_BASE=$3/$2-dl
export LOGS_LOCATION_BASE=$3/$2-dl/logs
export DYNAMODB_TABLE_NAME=$2-cdp-table
export IDBROKER_ROLE=$2-idbroker-role
sleep_duration=3


# Creating roles (and sleeping in between)

# IDBROKER
aws iam create-role --role-name $2-idbroker-role  --assume-role-policy-document file://$1/scripts/cdp/aws-pre-req/aws-ec2-role-trust-policy.json
sleep $sleep_duration 

aws iam create-instance-profile --instance-profile-name $2-idbroker-role
sleep $sleep_duration 

aws iam add-role-to-instance-profile --instance-profile-name $2-idbroker-role --role-name $2-idbroker-role
sleep $sleep_duration 


aws iam attach-role-policy --role-name $2-idbroker-role --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-idbroker-assume-role-policy
sleep $sleep_duration 


# DL ADMIN

cat $1/scripts/cdp/aws-pre-req/aws-idbroker-role-trust-policy.json  | sed s/AWS_ACCOUNT_ID/$AWS_ACCOUNT_ID/g | sed s/IDBROKER_ROLE/$IDBROKER_ROLE/g  > $1/scripts/cdp/aws-pre-req/tmp
aws iam create-role --role-name $2-datalake-admin-role --assume-role-policy-document file://$1/scripts/cdp/aws-pre-req/tmp
sleep $sleep_duration 


aws iam attach-role-policy --role-name $2-datalake-admin-role --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-bucket-policy-s3access
sleep $sleep_duration 

aws iam attach-role-policy --role-name $2-datalake-admin-role --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-dynamodb-policy
sleep $sleep_duration 

aws iam attach-role-policy --role-name $2-datalake-admin-role --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-datalake-admin-policy-s3access
sleep $sleep_duration 


# LOG

aws iam create-role --role-name $2-log-role --assume-role-policy-document file://$1/scripts/cdp/aws-pre-req/aws-ec2-role-trust-policy.json
sleep $sleep_duration 

aws iam attach-role-policy --role-name $2-log-role --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-log-policy-s3access
sleep $sleep_duration 

aws iam attach-role-policy --role-name $2-log-role --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-bucket-policy-s3access
sleep $sleep_duration 


# RANGER AUDIT

aws iam create-role --role-name $2-ranger-audit-role --assume-role-policy-document file://$1/scripts/cdp/aws-pre-req/tmp
sleep $sleep_duration 

aws iam attach-role-policy --role-name $2-ranger-audit-role --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-bucket-policy-s3access
sleep $sleep_duration 

aws iam attach-role-policy --role-name $2-ranger-audit-role --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-ranger-audit-policy-s3access
sleep $sleep_duration 

aws iam attach-role-policy --role-name $2-ranger-audit-role --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/$2-dynamodb-policy
sleep $sleep_duration 


rm $1/scripts/cdp/aws-pre-req/tmp

echo "Roles Created!"