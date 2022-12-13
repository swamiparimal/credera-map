## This function is used for the lambda function
## It is supposed to just do a simple log


import os
import logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)
from datetime import datetime
import boto3

def lambda_handler(event, context):
    last_file = str(grab_last_file())
    timestamp = str(datetime.now())
    filename = 'output-file' + timestamp + '.txt'
    # s3c = boto3.client('s3')
    s3 = boto3.resource('s3')
    
    new_name = timestamp + " " + last_file

    altering_file = s3.Object('tf-landing-bucket', last_file)

    copy_source = {
        'Bucket': 'tf-landing-bucket',
        'Key': last_file
    }
    s3.meta.client.copy(copy_source, 'ending-bucket', new_name)


    # s3c.put_object(
    #     Bucket='ending-bucket',
    #     Key= filename,
    #     Body=output,
    #     ContentType='text/plain',
    # )


def grab_last_file():
    s3 = boto3.resource('s3')
    begin_bucket = s3.Bucket('tf-landing-bucket')
    files = begin_bucket.objects.filter()
    files = [obj.key for obj in sorted(files, key= lambda x: x.last_modified, reverse=True)]
    print(files, type(files))
    last_file = files[0]
    return last_file
