##ECS cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "myreactclusters"
}

#The Task Definition used in conjunction with the ECS service
resource "aws_ecs_task_definition" "test_def" {
  family = "myreactapp-family"
  # container definitions describes the configurations for the task
  container_definitions = jsonencode(
    [
      {
        "name" : "myreactapp-container",
        "image" : "${aws_ecr_repository.ecr-demo.repository_url}:latest",
        "entryPoint" : []
        "essential" : true,
        "networkMode" : "awsvpc",
        "portMappings" : [
          {
            "containerPort" : var.container_port,
            "hostPort" : var.container_port,
          }
        ]
      }
    ]
  )
  #Fargate is used as opposed to EC2, so we do not need to manage the EC2 instances. Fargate is serveless
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  #execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  execution_role_arn          = var.ecsTaskExecutionRole
  task_role_arn            = var.ecsTaskRole
}

#The ECS service described. This resources allows you to manage tasks
resource "aws_ecs_service" "ecs_service" {
  name                = "reactapp-service"
  cluster             = aws_ecs_cluster.ecs_cluster.arn
  task_definition     = aws_ecs_task_definition.test_def.arn
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"
  desired_count       = 1 # the number of tasks you wish to run

  network_configuration {
    subnets          = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
    security_groups  = [aws_security_group.ecs_sg.id, aws_security_group.alb_sg.id]
    assign_public_ip = true
  }


  #   network_configuration {
  #     subnets          = [var.us-east-1a-pvt-subnet, var.us-east-1b-pvt-subnet]
  #     assign_public_ip = true # testing purpose provided true
  #     security_groups  = [aws_security_group.ecs_sg.id, aws_security_group.alb_sg.id]
  #   }

  #   # This block registers the tasks to a target group of the loadbalancer.
  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn #the target group defined in the alb file
    container_name   = "myreactapp-container"
    container_port   = var.container_port
  }
  depends_on = [aws_lb_listener.listener]
}
