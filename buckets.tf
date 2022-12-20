
provider "aws" {
  region = "us-east-2"
  profile = "default"
}

#resource
resource "aws_s3_bucket" "mybucket"{
  bucket = "tf-landing-bucket"
  tags = {
    Name = "Testing Bucket"
  }
  acl = "private"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_notification" "sqs_notification" {
  bucket = "tf-landing-bucket"

  queue {
    queue_arn     = "arn:aws:sqs:us-east-2:298041761968:landingbucketsqs"
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".log"
  }
}
resource "aws_s3_bucket" "ending_bucket"{
  bucket = "ending-bucket"
  tags = {
    Name = "Staged Bucket"
  }
  acl = "private"

  versioning {
    enabled = true
  }
}