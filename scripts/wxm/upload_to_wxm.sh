#!/bin/sh
cd $3
docker run -v $3:/tmp uploader --env $1 --upload-type TEZ_PROTOBUF_APPLICATIONS --file $2  