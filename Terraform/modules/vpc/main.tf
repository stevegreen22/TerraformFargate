# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_vpc
# Using the default vpc rather than create a new

resource "aws_default_vpc" "default" {
  cidr_block = aws_default_vpc.default.cidr_block

  tags = {
    Name = "Default VPC"
    Env  = var.environment
  }
}


# terraform import aws_default_vpc.default vpc-3e6abe44