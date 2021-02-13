# ecs variables file that declares the variables.

variable "environment" {
  description = "The name of the environment"
}

variable "availability_zones" {
  type        = list
  description = "List of availability zones you want. Example: eu-west-1a and eu-west-1b"
}

variable "ecs_aws_ami" {
  description = "The AWS ami id to use for ECS"
}

variable "max_size" {
  description = "Maximum size of the nodes in the cluster"
}

variable "min_size" {
  description = "Minimum size of the nodes in the cluster"
}

variable "desired_capacity" {
  description = "The desired capacity of the cluster"
}

variable "instance_type" {
  description = "AWS instance type to use"
}

variable "cluster" {
  default     = "LinTest"
  description = "The name of the ECS cluster"
}