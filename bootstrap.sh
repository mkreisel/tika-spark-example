#!/bin/bash
# Expects an input variable with the name of the S3 directory holding your Tika JARs
JARS_S3_PATH=$1
aws s3 cp s3://$JARS_S3_PATH/tika-core-1.26.jar /mnt/var/lib/hadoop/steps/tika-core-1.26.jar
aws s3 cp s3://$JARS_S3_PATH/tika-parsers-1.26.jar /mnt/var/lib/hadoop/steps/tika-parsers-1.26.jar