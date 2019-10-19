sudo yum -y install git gcc

mkdir test
cd test

git clone https://github.com/paulvid/hive-testbench.git

cd hive-testbench

./tpcds-build.sh

#./tpcds-setup.sh 100