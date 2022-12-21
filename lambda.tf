##IAM Policy 
data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

##Code here archives the Python file for the lambda function into a .zip
provider "archive" {}

data "archive_file" "lambda_function_folder" {

  type = "zip"
  source_dir = "code_map"
  output_path = "code_map.zip"
}


##Creates an IAM role for the lambda function called "iam_for_lambda"
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}


##Logging function that grab the handler function from the Python file
resource "aws_lambda_function" "converting_function" {
  function_name = "convert_csv"
  filename = "code_map.zip"
  source_code_hash = data.archive_file.lambda_function_folder.output_base64sha256
  role = "arn:aws:iam::298041761968:role/map-iam-lambda"
  handler = "lambda_function.lambda_handler"
  runtime = "python3.9"
  layers = ["arn:aws:lambda:us-east-2:298041761968:layer:pytz-layer:1",
  "arn:aws:lambda:us-east-2:298041761968:layer:numpy-layer:1",
  "arn:aws:lambda:us-east-2:336392948345:layer:AWSSDKPandas-Python39:2"]
  timeout = 30
  
}
##Lambda bucket permission
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "arn:aws:lambda:us-east-2:298041761968:function:convert_csv"
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::tf-landing-bucket"
}


##S3 bucket notification/trigger. It is linked to the logging lambda function
resource "aws_s3_bucket_notification" "bucket_noticification"{
    bucket = "tf-landing-bucket"
    queue {
      queue_arn = "arn:aws:sqs:us-east-2:298041761968:landingbucketsqs"
      events = ["s3:ObjectCreated:*"]
    }

    depends_on = [aws_lambda_permission.allow_bucket]
}

resource "aws_lambda_event_source_mapping" "attaching_sqs_to_lambda" {
  event_source_arn = "arn:aws:sqs:us-east-2:298041761968:landingbucketsqs"
  function_name    = "arn:aws:lambda:us-east-2:298041761968:function:convert_csv"
}
