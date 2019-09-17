#!/bin/sh
docker run -v $3:/tmp uploader --env $1 --upload-type SPARK_APP_HISTORY --file $2 --auth-file altus.json