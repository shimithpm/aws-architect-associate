#!/usr/bin/env bash
echo "shimith"
if [ -z "$1" ]; then
    echo " pass bucket name"
    exit 1
fi

bucket_name=$1
echo $bucket_name

aws s3api \
create-bucket \
--bucket $bucket_name \
--region 'us-east-1'