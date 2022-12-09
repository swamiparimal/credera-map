
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