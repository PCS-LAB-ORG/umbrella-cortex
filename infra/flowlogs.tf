resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "/aws/vpc/flowlogs/umbrella"
  retention_in_days = 30

  tags = {
    owner = var.owner
  }
}


resource "aws_flow_log" "vpc_flow_log" {
  traffic_type = "ALL"
  log_destination = aws_s3_bucket.tfstate_bucket_umbrella.arn
  log_destination_type = "s3"
  vpc_id               = aws_vpc.umbrella.id
   tags = {
    owner = var.owner
  }
}