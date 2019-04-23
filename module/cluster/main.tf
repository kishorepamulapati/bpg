resource "aws_ecs_cluster" "ecs_main" {
  count = "${length(var.clu)}"
  name = "${element("${var.clu}",count.index)}"
}
resource "aws_ecs_task_definition" "service" {
  count = "${length(var.json)}"
  family  =  "${element(var.task,count.index)}"
  container_definitions = "${file("${path.module}/temp/${element(var.json,count.index)}.json")}"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = "${element(var.cpu,count.index)}"
  memory = "${element(var.memory,count.index)}"
   task_role_arn ="${var.ecs_logs}"
}
resource "aws_ecs_service" "ecs_hn_service" {
  count   = "${length(var.json)}"
  name = "${element(var.json,count.index)}"
  iam_role = ""
  cluster = "${element(aws_ecs_cluster.ecs_main.*.id,count.index )}"
  launch_type = "FARGATE"
  network_configuration {
    subnets = ["subnet-0cbc1c31"]
  }
  desired_count = "1"
  task_definition = "${element(aws_ecs_task_definition.service.*.arn,count.index)}"
 load_balancer {
   container_name ="${element(var.lb-name,count.index)}"
 container_port = "${element(var.lb-port,count.index)}"
   target_group_arn = "${element(var.nl,count.index)}"
 }
}
resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/${element(aws_ecs_cluster.ecs_main.*.name,count.index)}/${element(aws_ecs_service.ecs_hn_service.*.name,count.index)}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}
resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "scale-down"
  policy_type        = "StepScaling"
  resource_id        = "${aws_appautoscaling_target.ecs_target.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.ecs_target.scalable_dimension}"
service_namespace  = "${aws_appautoscaling_target.ecs_target.service_namespace}"

 step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}
resource "aws_cloudwatch_metric_alarm" "ecs-cloudwatch" {
  count = "${length(var.json)}"
  alarm_name = "${element(var.json,count.index)}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    ClusterName       = "${element(aws_ecs_cluster.ecs_main.*.arn,count.index )}"
  }
}





