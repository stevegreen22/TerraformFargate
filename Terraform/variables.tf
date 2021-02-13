# We're bother declaring and defining the variables here
# so is there any need for the separate file?  Should these
# have the default values set?

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The AWS profile to use."
  default     = "default"
}


variable "environment" {
  description = "A name to describe the environment we're creating."
}

variable "aws_ecs_ami" {
  description = "The AMI to seed ECS instances with."
}

variable "availability_zones" {
  description = "The AWS availability zones to create subnets in."
  type = list
}

variable "max_size" {
  description = "Maximum number of instances in the ECS cluster."
}

variable "min_size" {
  description = "Minimum number of instances in the ECS cluster."
}

variable "desired_capacity" {
  description = "Ideal number of instances in the ECS cluster."
}

variable "instance_type" {
  description = "Size of instances in the ECS cluster."
}
