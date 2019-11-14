#!/bin/bash 


 display_usage() { 
	echo "
Usage:
    $(basename "$0") <base_dir> <servername> <truststore_password> [--help or -h]

Description:
    Gets the list of databases in Glue Catalog

Arguments:
    servername:          name of the server running knox client
    truststore_password: password for the trustore
    base_dir:            the base directory of the emr to cdp demo
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

openssl s_client -servername $2 -connect $2:8443 -showcerts </dev/null | openssl x509 -outform PEM > $1/scripts/cdp/gateway.pem; keytool -import -alias gateway-identity -file $1/scripts/cdp/gateway.pem -keystore $1/scripts/cdp/gateway.jks -storepass $3  -noprompt