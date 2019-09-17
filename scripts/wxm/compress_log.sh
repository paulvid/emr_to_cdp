#!/bin/sh

cd $1/raw

tar -czf $2.tar.gz $2

mv $2.tar.gz ../compressed/

cd -