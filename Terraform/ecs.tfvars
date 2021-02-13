#tfvars defines the variables.
#variables files declares them.

environment = "test"
aws_profile = "default"
aws_region = "us-east-1"

# The AMI to seed ECS instances with.
# Leave empty to use the latest Linux 2 ECS-optimized AMI by Amazon.
aws_ecs_ami = ""


# The AWS availability zones to create subnets in.
# For high-availability, we need at least two.
availability_zones = ["us-east-1a", "us-east-1b"]

# ECS cluster size details.
max_size = 1
min_size = 1
desired_capacity = 1
instance_type = "t2.micro"