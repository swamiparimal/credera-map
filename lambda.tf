
resource "aws_lambda_function" "test_lambda" {
  s3_bucket = "tf-landing-bucket"
  s3_key = "sampledata.zip"
  function_name = "terraform-test"
  handler = "module.handler"
  runtime = "python3.9"
  timeout = 180
  role = "arn:aws:iam::298041761968:role/map-iam-lambda"
}