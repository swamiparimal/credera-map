## FIFO SQS Created. Will be eventually connected to both landing S3 bucket and Glue Crawler
resource "aws_sqs_queue" "map-sqs-frombucket" {
  name                        = "landingbucketsqs"
  fifo_queue                  = false
  content_based_deduplication = false
}

resource "aws_sqs_queue_policy" "sqs_policy_map" {
  queue_url = "https://sqs.us-east-2.amazonaws.com/298041761968/landingbucketsqs"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws:sqs:us-east-2:298041761968:landingbucketsqs"
    }
  ]
}
POLICY
}