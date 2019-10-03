#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <clustername> <region> <log_uri> <key> <instanceprofile> <subnet> <slaveSG> <masterSG>[--help or -h]

Description:
    Launches as 3 nodes (1 Master, 2 cores) spark EMR cluster.

Arguments:
    clustername:        name of your cluster
    region:             region where to launch your cluster
    log_uri:            bucket path for logs
    key:                ssh key name in AWS
    instanceprofile:    AWS instance profile
    subnet:             AWS subnet id
    slaveSG:            AWS slave security group
    masterSG:           AWS master security group
    --help or -h:   displays this help"

}

# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $1 == "--help") ||  $1 == "-h" ]] 
then 
    display_usage
    exit 0
fi 


# Check the numbers of arguments
if [  $# -lt 8 ] 
then 
    echo "Not enough arguments!"
    display_usage
    exit 1
fi 

if [  $# -gt 8 ] 
then 
    echo "Too many arguments!"
    display_usage
    echo $#
    exit 1
fi 




#aws emr create-cluster --applications Name=Ganglia Name=Spark Name=Zeppelin --ec2-attributes '{"KeyName":"'$4'","InstanceProfile":"'$5'","SubnetId":"'$6'","EmrManagedSlaveSecurityGroup":"'$7'","EmrManagedMasterSecurityGroup":"'$8'"}' --service-role EMR_DefaultRole --enable-debugging --release-label emr-5.26.0 --log-uri 's3n://'$3'/' --name $1 --instance-groups '[{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":2}]},"InstanceGroupType":"MASTER","InstanceType":"m5.xlarge","Name":"Master Instance Group"},{"InstanceCount":2,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":2}]},"InstanceGroupType":"CORE","InstanceType":"m5.xlarge","Name":"Core Instance Group"}]' --configurations '[{"Classification":"spark","Properties":{}}]' --scale-down-behavior TERMINATE_AT_TASK_COMPLETION --region $2

aws emr create-cluster --applications Name=Ganglia Name=Hadoop Name=Hive Name=Hue Name=Mahout Name=Pig Name=Tez --ec2-attributes '{"KeyName":"'$4'","InstanceProfile":"'$5'","SubnetId":"'$6'","EmrManagedSlaveSecurityGroup":"'$7'","EmrManagedMasterSecurityGroup":"'$8'"}' --service-role EMR_DefaultRole --enable-debugging --release-label emr-5.27.0 --log-uri 's3n://'$3'/' --name $1 --instance-groups '[{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":2}]},"InstanceGroupType":"MASTER","InstanceType":"m5.xlarge","Name":"Master Instance Group"},{"InstanceCount":5,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":2}]},"InstanceGroupType":"CORE","InstanceType":"m5.xlarge","Name":"Core Instance Group"}]' --scale-down-behavior TERMINATE_AT_TASK_COMPLETION --configurations '[{"Classification":"tez-site","Properties":{"tez.history.logging.service.class":"org.apache.tez.dag.history.logging.proto.ProtoHistoryLoggingService","tez.history.logging.proto-base-dir":"/nifi"}}]' --region $2