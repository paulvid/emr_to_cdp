#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <base_dir> <prefix> <region> [--help or -h]

Description:
    Creates buckets and subdirectory for CDP environment

Arguments:
    base_dir: the base directory of the emr to cdp demo
    prefix:   prefix for your bucket (root will be <prefix>-cdp-bucket)
    region:   region of your bucket
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


if [ $(aws s3api head-bucket --bucket $bucket 2>&1 | wc -l) -gt 0 ] 
then
    aws s3api create-bucket --bucket $bucket --region $3 --create-bucket-configuration LocationConstraint=$3 > /dev/null 2>&1
fi

aws s3api put-object --bucket $bucket --key $2-dl/logs/ > /dev/null 2>&1
aws s3api put-object --bucket $bucket --key $2-dl/ranger/audit/ > /dev/null 2>&1
aws s3api put-object --bucket $bucket --key $2-dl/dataeng/ > /dev/null 2>&1
aws s3api put-object --bucket $bucket --key $2-dl/datasci/ > /dev/null 2>&1




echo '{"bucket": "'$2'-cdp-bucket"}'