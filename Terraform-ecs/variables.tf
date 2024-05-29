variable "region" {
  description = "Main region for all resources"
  type        = string
}
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the main VPC"
}
variable "public_subnet_1" {
  type        = string
  description = "CIDR block for public subnet 1"
}

variable "public_subnet_2" {
  type        = string
  description = "CIDR block for public subnet 2"
}

variable "availibilty_zone_1" {
  type        = string
  description = "First availibility zone"
}

variable "availibilty_zone_2" {
  type        = string
  description = "First availibility zone"
}

variable "container_port" {
  description = "portexposed on the docker image"
}
variable "app_image" {
  default     = "992382516702.dkr.ecr.us-east-1.amazonaws.com/myecrrepo"
  description = "docker image to run in this ECS cluster"
}
variable "fargate_cpu" {
  default     = "1024"
  description = "fargate instacne CPU units to provision,my requirent 1 vcpu so gave 1024"
}

variable "fargate_memory" {
  default     = "2048"
  description = "Fargate instance memory to provision (in MiB) not MB"
}
variable "ecs_task_execution_role" {
  default     = "myECcsTaskExecutionRole"
  description = "ECS task execution role name"
}
variable "app_count" {
  default     = "1" #choose 2 bcz i have choosen 2 AZ
  description = "numer of docker containers to run"
}
variable "ecsTaskExecutionRole" {
  type        = string
  default = "arn:aws:iam::992382516702:role/ecsTaskExecutionRole"
}
variable "ecsTaskRole" {
  type        = string
  default = "arn:aws:iam::992382516702:role/ecsTaskExecutionRole"
}
