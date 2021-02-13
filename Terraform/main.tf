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

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group" "lb" {
  name        = "loadbalancer-sg"
  description = "access control to the alb"

  # incoming port 80 web from all
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  # all outbound allowed
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs_tasks_sg" {
  name        = "ecs-tasks-security-group"
  description = "Allow inbound access from the ALB to the ECS tasks"

  # arbitrary port used
  ingress {
    from_port       = 4000
    protocol        = "tcp"
    to_port         = 4000
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# alb
resource "aws_lb" "alb" {
  name               = "alb"
  subnets            = data.aws_subnet_ids.default.ids
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]

  tags = {
    environment = "test"
    app         = "dockkerised java hello"
  }
}

#target group
resource "aws_lb_target_group" "tg" {
  name = "alb-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = data.aws_vpc.default.id
  target_type = "ip"

  #health_check {}
}

#listener
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

#ecr repo
resource "aws_ecr_repository" "repo" {
  name = "ecr_repo"
}

#IAM role for executing the tasks
data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

     principals {
       identifiers = ["ecs-tasks.amazonaws.com"]
       type        = "Service"
     }
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecs-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
