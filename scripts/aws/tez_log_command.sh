rm -rf app_data dag_data dag_meta
rm tez-payloads-*.tar.gz 

hdfs dfs -copyToLocal /nifi/app_data
hdfs dfs -copyToLocal /nifi/dag_data
hdfs dfs -copyToLocal /nifi/dag_meta

export NOW=$(date +"%s")

tar -czf tez-payloads-$NOW.tar.gz app_data dag_data dag_meta

