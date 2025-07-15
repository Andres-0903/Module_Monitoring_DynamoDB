resource "aws_sns_topic" "alertresource" {
  name = "alertresource-topic"
}
resource "aws_sns_topic_subscription" "alertresource" {
  topic_arn = aws_sns_topic.alertresource.arn
  protocol  = "email"
  endpoint  = "arenasandres7@gmail.com"
}

#Llamada al modulo
module "alarm_DynamoDB_WriteThrottleEvents" {
  source = "./Monitoring_CW_DynamoDB"

  alarm_name          = "WriteThrottleEvents-DynamoDB"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "WriteThrottleEvents"
  namespace           = "AWS/DynamoDB"
  period              = 30
  statistic           = "Average"
  threshold           = 5
  alarm_description   = "Alarma para altos eventos de acelarion del indice"

  alarm_actions = [aws_sns_topic.alertresource.arn]

  dimensions = {
    TableName = "MyDynamo"
  }

}

module "monitoring_dynamodb_errors" {
  source = "./Monitoring_CW_DynamoDB"

  alarm_name          = "SystemErrors-DynamoDB"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "SystemErrors"
  namespace           = "AWS_DynamoDB"
  period              = 30
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Alarma por errores internos en DynamoDB"
  alarm_actions       = [aws_sns_topic.alertresource.arn]

  dimensions = {
    TableName = "MyDynamo"
  }
}

module "monitoring_dynamodb_latency" {
  source = "./Monitoring_CW_DynamoDB"

  alarm_name          = "HighLatency-DynamoDB"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "SuccessfulRequestLatency"
  namespace           = "AWS_DynamoDB"
  period              = 30
  statistic           = "Average"
  threshold           = 100
  alarm_description   = "Alarma por alta latencia en solicitudes exitosas"
  alarm_actions       = [aws_sns_topic.alertresource.arn]

  dimensions = {
    TableName = "MyDynamo"
  }
}

module "monitoring_dynamodb_ReturnedBytes" {
  source = "./Monitoring_CW_DynamoDB"

  alarm_name          = "ReturnedBytes-DynamoDB"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ReturnedBytes"
  namespace           = "AWS_DynamoDB"
  period              = 30
  statistic           = "Sum"
  threshold           = 11
  alarm_description   = "Alarma The number of bytes returned by GetRecords"
  alarm_actions       = [aws_sns_topic.alertresource.arn]

  dimensions = {
    TableName = "MyDynamo"
  }
}

