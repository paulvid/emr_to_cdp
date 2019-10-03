mkdir test
cd test

git clone https://github.com/hortonworks/hive-testbench

cd hive-testbench

sed $'s/^HIVE=*/HIVE=\"hive \"\\\n#HIVE=/g' $(pwd)/tpcds-setup.sh > temp.sh
mv temp.sh tpcds-setup.sh

./tpcds-build.sh

./tpcds-setup.sh 100