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


if [$(aws s3api put-object --bucket $2-cdp-bucket --key $2-dl/logs/ | wc -l) -eq 0 ] 
then
    aws s3api create-bucket --bucket $2-cdp-bucket --region $3
    aws s3api put-object --bucket $2-cdp-bucket --key $2-dl/logs/ 2&>1
    aws s3api put-object --bucket $2-cdp-bucket --key $2-dl/ranger/audit/ 2&>1
    aws s3api put-object --bucket $2-cdp-bucket --key $2-dl/dataeng/ 2&>1
    aws s3api put-object --bucket $2-cdp-bucket --key $2-dl/datasci/ 2&>1
else 
    aws s3api put-object --bucket $2-cdp-bucket --key $2-dl/logs/ 2&>1
    aws s3api put-object --bucket $2-cdp-bucket --key $2-dl/ranger/audit/ 2&>1
    aws s3api put-object --bucket $2-cdp-bucket --key $2-dl/dataeng/ 2&>1
    aws s3api put-object --bucket $2-cdp-bucket --key $2-dl/datasci/ 2&>1
fi




echo '{"bucket": "'$2'-cdp-bucket"}'