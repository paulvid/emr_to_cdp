#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <prefix> [--help or -h]

Description:
    Launches as 3 nodes (1 Master, 2 workers) CDP data engineering cluster.

Arguments:
    prefix:         prefix of your assets
    --help or -h:   displays this help"

}

# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $1 == "--help") ||  $1 == "-h" ]] 
then 
    display_usage
    exit 0
fi 


# Check the numbers of arguments
if [  $# -lt 1 ] 
then 
    echo "Not enough arguments!"
    display_usage
    exit 1
fi 

if [  $# -gt 1 ] 
then 
    echo "Too many arguments!"
    display_usage
    exit 1
fi 

subnetId=$(cdp environments describe-environment --environment-name $1-cdp-env | jq -r .environment.network.subnetIds[0])

cdp datahub create-aws-cluster --cluster-name $1-de-cluster \
    --environment-name $1-cdp-env \
    --cluster-template-name "CDP 1.2 - Data Engineering: Apache Spark, Apache Hive, Apache Oozie" \
    --instance-groups "nodeCount=1,instanceGroupName=master,instanceGroupType=GATEWAY,instanceType=m5.2xlarge,rootVolumeSize=50,attachedVolumeConfiguration=[{volumeSize=64,volumeCount=2,volumeType=standard}],recoveryMode=MANUAL,volumeEncryption={enableEncryption=false}"  "nodeCount=10,instanceGroupName=worker,instanceGroupType=CORE,instanceType=m5.2xlarge,rootVolumeSize=50,attachedVolumeConfiguration=[{volumeSize=64,volumeCount=2,volumeType=standard}],recoveryMode=MANUAL,volumeEncryption={enableEncryption=false}" "nodeCount=0,instanceGroupName=compute,instanceGroupType=CORE,instanceType=m5.2xlarge,rootVolumeSize=50,attachedVolumeConfiguration=[{volumeSize=64,volumeCount=2,volumeType=standard}],recoveryMode=MANUAL,volumeEncryption={enableEncryption=false}" \
    --subnet-id $subnetId \
    --image id="dfcf07fb-b1a2-49ba-5320-6be0fb13a9b0",catalogName="cloudbreak-default"  