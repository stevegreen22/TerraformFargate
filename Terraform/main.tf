provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

# todo: remove, added to sanity check modules and config being pulled in.
#resource "aws_instance" "test2-ec2-instance" {
#  ami           = "ami-047a51fa27710816e"
#  instance_type = "t2.micro"
#}

module "ecs" {
  source = "./modules/ecs"

  environment          = var.environment
  cluster              = var.environment
  availability_zones   = var.availability_zones
  max_size             = var.max_size
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity
  instance_type        = var.instance_type
  ecs_aws_ami          = var.aws_ecs_ami
}
