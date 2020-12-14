resource "aws_ecs_cluster" "web_service" {
  name = "web-service-cluster-${var.env}"
}

resource "aws_ecs_task_definition" "web_service" {
  network_mode             = "awsvpc"
  family                   = "fargate"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.web_service_task_execution_role.arn
  task_role_arn            = aws_iam_role.web_service_task_role.arn
  container_definitions = file("${path.module}/task_definitions/web_service.json")
}

resource "aws_ecs_service" "web_service" {
 name                               = "web_service-${var.env}"
 cluster                            = aws_ecs_cluster.web_service.id
 task_definition                    = aws_ecs_task_definition.web_service.arn
 desired_count                      = 3
 deployment_minimum_healthy_percent = 50
 deployment_maximum_percent         = 200
 launch_type                        = "FARGATE"
 scheduling_strategy                = "REPLICA"
 
 network_configuration {
   security_groups  = [aws_security_group.ecs_tasks.id]
   subnets          = aws_subnet.private.*.id
   assign_public_ip = false
 }
 
 load_balancer {
   target_group_arn = aws_alb_target_group.web_service.arn
   container_name   = "fargate-app"
   container_port   = 80
 }
 
 lifecycle {
   ignore_changes = [desired_count]
 }
}
