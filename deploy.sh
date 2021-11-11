#!/bin/bash
INPUT_S3_PATH=$1 # Full path to S3 directory containing documents for text extraction (e.g. s3://my-bucket/data/*)
OUTPUT_S3_PATH=$2 # S3 path where extracted text will be written (e.g. s3://my-bucket/results)
RESOURCES_S3_PATH=$3 # S3 path where JARs and bootstrap script will be stored (e.g. my-bucket/jars)

aws s3 cp lib/tika-core-1.26.jar s3://$RESOURCES_S3_PATH/tika-core-1.26.jar 
aws s3 cp lib/tika-parsers-1.26.jar s3://$RESOURCES_S3_PATH/tika-parsers-1.26.jar 
aws s3 cp tika-spark_2.12-1.0.jar s3://$RESOURCES_S3_PATH/tika-spark_2.12-1.0.jar
aws s3 cp bootstrap.sh s3://$RESOURCES_S3_PATH/bootstrap.sh

# Create roles with EMR permissions and S3 access
aws emr create-default-roles

# Create cluster to execute the job. It will be destroyed upon completion.
aws emr create-cluster --name "Tika Spark Example" --release-label emr-6.3.0 --applications Name=Hadoop Name=Spark Name=Hive \
--enable-debugging \
--log-uri s3://$RESOURCES_S3_PATH/tika-spark-logs \
--instance-type m5.xlarge --instance-count 2 \
--steps Type=CUSTOM_JAR,Name="Tika Spark",Jar="command-runner.jar",ActionOnFailure=TERMINATE_CLUSTER,Args=["spark-submit","--deploy-mode","cluster","--master","yarn","--jars","/mnt/var/lib/hadoop/steps/tika-core-1.26.jar\\,/mnt/var/lib/hadoop/steps/tika-parsers-1.26.jar","s3://$RESOURCES_S3_PATH/tika-spark_2.12-1.0.jar","$INPUT_S3_PATH","$OUTPUT_S3_PATH"] \
--use-default-roles \
--bootstrap-actions Path=s3://$RESOURCES_S3_PATH/bootstrap.sh,Name="Copy Jars",Args=$RESOURCES_S3_PATH \
--auto-terminate
