#!/bin/bash 
 
display_usage() { 
	echo "
Usage:
    $(basename "$0") <S3URI> <localpath> [--silent or -s] [--help or -h]

Description:
    Simple script downloading all container logs from s3 bucket using aws cli.
    AWS cli must be configured beforehand.

Arguments:
    S3URI:          s3 URI of source application log
    localpath:      local destination folder
    --silent or -s: only stdout archive path
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

if [  $# -gt 3 ] 
then 
    echo "Too many arguments!"
    display_usage
    exit 1
fi 

silent=0
if [  $# -eq 3 ] 
then
    if [[ $3 == "--silent" || $3 == "-s" ]]
    then
        silent=1
    else
        echo "Wrong arguments!"
        display_usage
        exit 1
    fi
    
fi 


# 1. Create a tmp folders and dowloads all the things

if [ $silent -ne 1 ]
then
    echo "Creating tmp folders ..."
fi

mkdir $2/tmp/
mkdir $2/tmp/in
mkdir $2/tmp/out

if [ $silent -ne 1 ]
then
    echo "Downloading logs ..."
fi
aws s3 cp $1 $2/tmp/in --recursive >> /dev/null 2>&1

# 2. Unzips all stdout and moves them to tmp/out 
if [ $silent -ne 1 ]
then
    echo "Unzipping logs ..."
fi

files=`find $2/tmp/in -name "stdout.gz"`
i=1
for f in $files
do
    gunzip $f
    mv ${f/.gz} $2/tmp/out/stdout_$i
    i=$((i+1))
done

# 3. Tar.gz all stdout and moves them to destination folder
if [ $silent -ne 1 ]
then
    echo "Creating archive ..."
fi

archive_name=`echo $1 | awk -F '/' '{print $NF}'`"_log.tar.gz"
cd $2/tmp/out/
tar -czvf $2/$archive_name * >> /dev/null 2>&1
cd $2

# 4. Removes tmp folders
if [ $silent -ne 1 ]
then
    echo "Removing tmp folders ..."
fi
rm -rf $2/tmp

# 5. Exit Gracefully
if [ $silent -ne 1 ]
then
    echo "Done: successfully generated archive $2/$archive_name"
else 
    echo $2/$archive_name
fi
