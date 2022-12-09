## This function is used for the lambda function
## It is supposed to just do a simple log


import os
import logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)
from datetime import datetime
import boto3

def lambda_handler(event, context):
    output = output_func()
    timestamp = str(datetime.now())
    filename = 'output-file' + timestamp + '.txt'
    s3 = boto3.client('s3')

    s3.put_object(
        Bucket='ending-bucket',
        Key= filename,
        Body=output,
        ContentType='text/plain',
    )

    print("Lambda Function was triggered")
    logger.info('## ENVIRONMENT VARIABLES')
    logger.info(os.environ)
    logger.info('## EVENT')
    logger.info(event)


def output_func():
    timestamp = str(datetime.now())
    s = "From S3 bucket through Lambda to staged S3 using triggers at " + timestamp
    return s
