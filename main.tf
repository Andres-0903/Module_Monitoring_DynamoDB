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
  period              = 60
  statistic           = "Sum"
  threshold           = 0
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
  period              = 60
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
  period              = 60
  statistic           = "Average"
  threshold           = 30000 # 30000 ms = 30 segundos
  alarm_description   = "Cuando se supere la cantidad de segundos"
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
  period              = 60
  statistic           = "Average"
  threshold           = 500000 # 500000 bytes = 500 Kb
  alarm_description   = "Cuando se retornen hasta 500 kb"
  alarm_actions       = [aws_sns_topic.alertresource.arn]

  dimensions = {
    TableName = "MyDynamo"
  }
}

