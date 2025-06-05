resource "aws_cloudwatch_metric_alarm" "low_cpu_credit" {     # Creating a clodwatch resource called low_cpu_credit in code
  alarm_name          = "Low_CPU_Credit"                      # Naming the alarm low_cpu_credit on AWS
  comparison_operator = "LessThanThreshold"                   # If the unit being measured is less than the threshold then sound the alarm
  evaluation_periods  = 1                                     # 1 means to trigger the alarm as soon as possible
  metric_name         = "CPUCreditBalance"                    # This is what we are monitoring.  It is the CPU credit balance from on EC2 instance
  namespace           = "AWS/EC2"                             # Should be obvious but i think we are saying here that this applies to AWS/EC2
  period              = 300                                   # Checks the CPU credits every 5 minutes
  statistic           = "Average"                             # We want to check the average CPU credit
  threshold           = 5                                     # If CPU average credit falls below 5 then sound the alarm
  alarm_description   = "Alarm when CPU credits drop below 5" # A description for this resurce
  dimensions = {
    InstanceId = aws_instance.Morrowind_Server.id # Applying this clodwatch metric to our AWS instance (the Morrowind Server)
  }
  alarm_actions = [aws_sns_topic.alarm_topic.arn] # Applies this cloudwatch to a a sns
}

resource "aws_sns_topic" "alarm_topic" { # Creating a sns resource called alarm_topic in code
  name = "alarm-topic"                   # Naming the sns on AWS
}

resource "aws_sns_topic_subscription" "alarm_email" { # Creating a sns subscription resource called alarm_email in code
  topic_arn = aws_sns_topic.alarm_topic.arn           # Takes the sns topic resource we made and applies to to this sns topic
  protocol  = "email"                                 # Use email when the alarm sounds
  endpoint  = "alexlawrie123@gmail.com"               # The address to email
}