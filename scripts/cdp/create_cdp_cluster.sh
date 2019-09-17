#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <clustername> [--help or -h]

Description:
    Launches as 3 nodes (1 Master, 2 workers) CDP data engineering cluster.

Arguments:
    clustername:    name of your cluster
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

if [  $# -gt 2 ] 
then 
    echo "Too many arguments!"
    display_usage
    exit 1
fi 

cdp datahub create-aws-cluster --cli-input-json '{"name":"pvidal-oregon-dataengineering","workloadAnalytics":true,"environmentName":"pvidal-oregon-env","instanceGroups":[{"nodeCount":1,"name":"master","type":"GATEWAY","recoveryMode":"MANUAL","template":{"aws":{},"instanceType":"m5.2xlarge","rootVolume":{"size":50},"attachedVolumes":[{"size":100,"count":1,"type":"standard"}],"cloudPlatform":"AWS"},"recipeNames":[]},{"nodeCount":0,"name":"compute","type":"CORE","recoveryMode":"MANUAL","template":{"aws":{},"instanceType":"m5.xlarge","rootVolume":{"size":50},"attachedVolumes":[{"size":100,"count":1,"type":"standard"}],"cloudPlatform":"AWS"},"recipeNames":[]},{"nodeCount":2,"name":"worker","type":"CORE","recoveryMode":"MANUAL","template":{"aws":{},"instanceType":"m5.xlarge","rootVolume":{"size":50},"attachedVolumes":[{"size":100,"count":1,"type":"standard"}],"cloudPlatform":"AWS"},"recipeNames":[]}],"image":{"catalog":"cloudbreak-default","id":"1e16f45f-86c4-4b97-7802-ef1b0dc7373b"},"network":{"aws":{"subnetId":"subnet-072894bffc695d37a"}},"cluster":{"userName":"","password":"","databases":[],"cloudStorage":{"aws":{"s3Guard":{"dynamoTableName":"tbl_pvidaloregon"}},"locations":[{"type":"YARN_LOG","value":"s3a://pvidal-oregon/oplogs/yarn-app-logs"},{"type":"ZEPPELIN_NOTEBOOK","value":"s3a://pvidal-oregon/pvidal-oregon-dataengineering/zeppelin/notebook"},{"type":"HIVE_METASTORE_WAREHOUSE","value":"s3a://pvidal-oregon/warehouse/tablespace/managed/hive"},{"type":"HIVE_METASTORE_EXTERNAL_WAREHOUSE","value":"s3a://pvidal-oregon/warehouse/tablespace/external/hive"},{"type":"HIVE_REPLICA_WAREHOUSE","value":"s3a://pvidal-oregon/hive_replica_functions_dir"}],"identities":[{"s3":{"instanceProfile":"arn:aws:iam::081339556850:instance-profile/pvidal-one-role-to-rule-them-all"},"type":"LOG"}]},"cm":{"repository":{"version":"7.0.0","baseUrl":"http://cloudera-build-us-west-1.vpc.cloudera.com/s3/build/1377325/cm7/7.0.0/redhat7/yum/"},"products":[{"name":"CDH","version":"7.0.0-1.cdh7.0.0.p0.1376867","parcel":"http://cloudera-build-us-west-1.vpc.cloudera.com/s3/build/1376867/cdh/7.x/parcels/"}],"enableAutoTls":false},"exposedServices":["ALL"],"blueprintName":"CDP 1.0 - Data Engineering: Apache Spark, Apache Hive, Apache Oozie","validateBlueprint":false},"sdx":{"name":"pvidal-oregon-datalake"},"tags":{"userDefined":{"enddate":"12312019"}},"inputs":{}}' --cluster-name $1
