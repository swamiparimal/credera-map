## This function is used for the lambda function
## It is supposed to convert the last csv uploaded to a .parquet file


import json
import os
import logging
import pandas as pd
from datetime import datetime
import boto3
import pyarrow as pa
import pyarrow.parquet as pq

def lambda_handler(event, context):
    last_file = str(grab_last_file())
    timestamp = datetime.now()
    year = str(timestamp.year)
    month = timestamp.strftime("%B")
    day = str(timestamp.day)
    file_path = year+"/"+month+"/"+day+"/"
    s3_object = boto3.client('s3')
    s3 = boto3.resource('s3')

    new_name = str(timestamp)+ last_file.split('.')[0]
    if (last_file.split('.')[-1] == 'csv'):
        get_file = s3_object.get_object(Bucket='tf-landing-bucket', Key = last_file)

        body = get_file['Body']
        df = pd.DataFrame(body)
        end_name = file_path + new_name + ".parquet"
        table = pa.Table.from_pandas(df)
        pq.write_table(table, '/tmp/example.parquet')
        s3.Bucket('ending-bucket').upload_file('/tmp/example.parquet', end_name)
        
        return{
            'statusCode': 200,
            'body': json.dumps("Successfully uploaded parquet file")
        }

def grab_last_file():
    s3 = boto3.resource('s3')
    begin_bucket = s3.Bucket('tf-landing-bucket')
    files = begin_bucket.objects.filter()
    files = [obj.key for obj in sorted(files, key= lambda x: x.last_modified, reverse=True)]
    last_file = files[0]
    return last_file