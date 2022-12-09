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
data "archive_file" "zip" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function.zip"
}

##Creates an IAM role for the lambda function called "iam_for_lambda"
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}


##Original test function made at the beginning. It doesn't do anything really other than unzip a .zip
# resource "aws_lambda_function" "test_lambda" {
#   s3_bucket = "tf-landing-bucket"
#   s3_key = "sampledata.zip"
#   function_name = "terraform-test"
#   handler = "module.handler"
#   runtime = "python3.9"
#   timeout = 180
#   role = "arn:aws:iam::298041761968:role/map-iam-lambda"
# }

##Logging function that grab the handler function from the Python file
resource "aws_lambda_function" "logging_function" {
  function_name = "logging_function"
  filename = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256
  role = "arn:aws:iam::298041761968:role/map-iam-lambda"
  handler = "lambda_function.lambda_handler"
  runtime = "python3.9"

  
}
##Lambda bucket permission
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "arn:aws:lambda:us-east-2:298041761968:function:logging_function"
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::tf-landing-bucket"
}

##S3 bucket notification/trigger. It is linked to the logging lambda function
resource "aws_s3_bucket_notification" "bucket_noticification"{
    bucket = "tf-landing-bucket"

    lambda_function {
      lambda_function_arn = "arn:aws:lambda:us-east-2:298041761968:function:logging_function"
      events = ["s3:ObjectCreated:*"]
    }
    depends_on = [aws_lambda_permission.allow_bucket]
}
