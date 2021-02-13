provider "aws" {
  region = "us-east-1"
}

#resource "aws_instance" "test2-ec2-instance" {
#  ami           = "ami-047a51fa27710816e"
#  instance_type = "t2.micro"
#}

# define cluster resource.
resource "aws_ecs_cluster" "cluster" {
  name = var.cluster
}