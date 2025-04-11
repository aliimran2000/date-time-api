resource "aws_ecs_cluster" "main" {
  name = "datetime-api-cluster"
}

resource "aws_ecs_task_definition" "api" {
  family                   = "datetime-api-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([
    {
      name      = "datetime-api"
      image     = var.ecr_image_url
      essential = true
      portMappings = [{
        containerPort = 8080
        hostPort      = 8080
        protocol      = "tcp"
      }]
    }
  ])
}

resource "aws_ecs_service" "api" {
  name            = "datetime-api-service"
  cluster         = aws_ecs_cluster.main.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = 1

  network_configuration {
    subnets         = aws_subnet.public[*].id
    assign_public_ip = true
    security_groups  = [aws_security_group.fargate_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.api_tg.arn
    container_name   = "datetime-api"
    container_port   = 8080
  }

  depends_on = [aws_lb_listener.api_listener]
}