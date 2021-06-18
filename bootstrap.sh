#!/bin/bash
# Expects an input variable with the name of the S3 directory holding your Tika JARs
aws s3 cp s3://$1/tika-core-1.26.jar /mnt/var/lib/hadoop/steps/tika-core-1.26.jar
aws s3 cp s3://$1/tika-parsers-1.26.jar /mnt/var/lib/hadoop/steps/tika-parsers-1.26.jar