#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <base_dir> <prefix> <bucket> [--help or -h]

Description:
    Creates minimal set of policies for CDP env

Arguments:
    base_dir: the base directory of the emr to cdp demo
    prefix:   prefix for your policies
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
export STORAGE_LOCATION_BASE=$3'\/'$2'\-dl'
export LOGS_LOCATION_BASE=$3'\/'$2'\-dl\/logs'
export DYNAMODB_TABLE_NAME=$2'\-cdp\-table'
sleep_duration=3


# Creating policies (and sleeping in between)

aws iam create-policy --policy-name $2-idbroker-assume-role-policy --policy-document file://$1/scripts/cdp/aws-pre-req/aws-idbroker-assume-role-policy.json 
sleep $sleep_duration 

cat $1/scripts/cdp/aws-pre-req/aws-log-policy-s3access.json | sed s/LOGS_LOCATION_BASE/$LOGS_LOCATION_BASE/g > $1/scripts/cdp/aws-pre-req/tmp
aws iam create-policy --policy-name $2-log-policy-s3access --policy-document file://$1/scripts/cdp/aws-pre-req/tmp
sleep $sleep_duration 

cat $1/scripts/cdp/aws-pre-req/aws-ranger-audit-policy-s3access.json | sed s/STORAGE_LOCATION_BASE/$STORAGE_LOCATION_BASE/g | sed s/DATALAKE_BUCKET/$DATALAKE_BUCKET/g > $1/scripts/cdp/aws-pre-req/tmp
aws iam create-policy --policy-name $2-ranger-audit-policy-s3access --policy-document file://$1/scripts/cdp/aws-pre-req/tmp
sleep $sleep_duration 

cat  $1/scripts/cdp/aws-pre-req/aws-datalake-admin-policy-s3access.json | sed s/STORAGE_LOCATION_BASE/$STORAGE_LOCATION_BASE/g > $1/scripts/cdp/aws-pre-req/tmp
aws iam create-policy --policy-name $2-datalake-admin-policy-s3access --policy-document file://$1/scripts/cdp/aws-pre-req/tmp
sleep $sleep_duration 


cat $1/scripts/cdp/aws-pre-req/aws-bucket-policy-s3access.json  | sed s/DATALAKE_BUCKET/$DATALAKE_BUCKET/g > $1/scripts/cdp/aws-pre-req/tmp
aws iam create-policy --policy-name $2-bucket-policy-s3access --policy-document file://$1/scripts/cdp/aws-pre-req/tmp
sleep $sleep_duration   


cat $1/scripts/cdp/aws-pre-req/aws-dynamodb-policy.json | sed s/DYNAMODB_TABLE_NAME/$DYNAMODB_TABLE_NAME/g > $1/scripts/cdp/aws-pre-req/tmp
aws iam create-policy --policy-name $2-dynamodb-policy --policy-document file://$1/scripts/cdp/aws-pre-req/tmp
sleep $sleep_duration 

rm $1/scripts/cdp/aws-pre-req/tmp

echo "Minimum policies created!"