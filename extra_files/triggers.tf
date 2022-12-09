resource "aws_s3_bucket_notification" "bucket_noticification"{
    bucket = "tf-landing-bucket"

    lambda_function {
      lambda_function_arn = "arn:aws:lambda:us-east-2:298041761968:function:terraform-test"
      events = ["s3:ObjectCreated:*"]
      filter_suffix = ".zip"
    }
}

resource "aws_lambda_permission" "test" {
    statement_id = "AllowS3Invoke"
    action = "lambda:InvokeFunction"
    function_name = "terraform_test"
    principal = "s3.amazonaws.com"
    source_account = 298041761968
    source_arn = "arn:aws:s3:::tf-landing-bucket"
  
}