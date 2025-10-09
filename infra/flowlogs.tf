resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "/aws/vpc/flowlogs/umbrella"
  retention_in_days = 30

  tags = {
    owner = var.owner
  }
}

resource "aws_flow_log" "vpc_flow_log" {
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs.arn
  log_destination_type = "cloud-watch-logs"
  iam_role_arn         = "arn:aws:iam::aws:role/aws-service-role/flow-logs.amazonaws.com/AWSServiceRoleForFlowLogs"
  vpc_id               = aws_vpc.umbrella.id
  traffic_type         = "ALL"

  tags = {
    owner = var.owner
  }
}