## create new bucket
aws s3 mb s3://metadata-shimithdemo-123

## aws s3 putobject
aws s3api put-object --bucket metadata-shimithdemo-123 --key myfile.txt --metadata planet=earth

## aws get object
aws s3api head-object --bucket metadata-shimithdemo-123 --key myfile.txt

## clean up
aws s3 rm s3://metadata-shimithdemo-123/myfile.txt
aws s3 rb s3://metadata-shimithdemo-123