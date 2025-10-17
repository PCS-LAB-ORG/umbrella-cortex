resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "/aws/vpc/flowlogs/umbrella"
  retention_in_days = 30

  tags = {
    owner = var.owner
  }
}



resource "aws_iam_role" "flow_logs_role" {
  name = "flow-logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "logs.${var.region}.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "flow_logs_policy" {
  name = "flow-logs-policy"
  role = aws_iam_role.flow_logs_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_flow_log" "vpc_flow_log" {
  traffic_type = "ALL"
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs.arn
  log_destination_type = "cloud-watch-logs"
  vpc_id               = aws_vpc.umbrella.id
  iam_role_arn = aws_iam_role.flow_logs_role.arn
   tags = {
    owner = var.owner
  }
}