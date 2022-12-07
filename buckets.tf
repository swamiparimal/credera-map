
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