##This file created the initial AWS CloudWatch log group. I can't seem 
## to get it logging things correctly though. 

resource "aws_cloudwatch_log_group" "initial" {
  name = "InitialLogs"

  retention_in_days = 30

  tags = {
    Environment = "production"
    Application = "MAP"
  }
}