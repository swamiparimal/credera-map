
resource "aws_glue_crawler" "map_crawler" {
    database_name = "aws_s3_bucket.ending_bucket"
    name = "map_crawler"
    description = "glue crawler for map project. converts all to .parquet"
    #Grabbed the role arn from default IAM Glue service role
    role = "arn:aws:iam::298041761968:role/AWSGlueServiceRoleDefault"

    s3_target {
      path = "s3://tf-landing-bucket"
      event_queue_arn = "arn:aws:sqs:us-east-2:298041761968:landingbucketsqs"
    }



  
}