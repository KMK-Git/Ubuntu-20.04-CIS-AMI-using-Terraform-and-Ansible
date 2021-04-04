terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    encrypt = true
  }
}

provider "aws" {}

module "vpc" {
  source                           = "terraform-aws-modules/vpc/aws"
  version                          = "~> 2.0"
  name                             = var.vpc_name
  cidr                             = var.vpc_cidr
  azs                              = var.vpc_azs
  private_subnets                  = var.vpc_private_subnets
  public_subnets                   = var.vpc_public_subnets
  enable_dns_hostnames             = true
  enable_dns_support               = true
  enable_nat_gateway               = false
  enable_ssm_endpoint              = !var.is_public_instance
  ssm_endpoint_private_dns_enabled = var.is_public_instance ? null : true
  ssm_endpoint_security_group_ids = [
    module.endpoint_sg.this_security_group_id
  ]
  enable_ec2messages_endpoint              = !var.is_public_instance
  ec2messages_endpoint_private_dns_enabled = var.is_public_instance ? null : true
  ec2messages_endpoint_security_group_ids = [
    module.endpoint_sg.this_security_group_id
  ]
  enable_ssmmessages_endpoint              = !var.is_public_instance
  ssmmessages_endpoint_private_dns_enabled = var.is_public_instance ? null : true
  ssmmessages_endpoint_security_group_ids = [
    module.endpoint_sg.this_security_group_id
  ]
}

module "instance_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"
  vpc_id  = module.vpc.vpc_id
  name    = var.sg_name
  egress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = var.vpc_cidr
    }
  ]
}

module "endpoint_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"
  vpc_id  = module.vpc.vpc_id
  name    = var.sg_name
  ingress_with_source_security_group_id = [
    {
      protocol                 = "tcp"
      from_port                = 443
      to_port                  = 443
      source_security_group_id = module.instance_sg.this_security_group_id
    }
  ]
  egress_with_cidr_blocks = [
    {
      cidr_blocks = var.vpc_cidr
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
    }
  ]
}

module "instance_role" {
  source                  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version                 = "~> 3.0"
  create_instance_profile = true
  create_role             = true
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
  role_name         = var.iam_role_name
  role_requires_mfa = false
  trusted_role_services = [
    "ec2.amazonaws.com"
  ]
}


data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
    ]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"
    ]
  }

  owners = [
    "099720109477"
  ]
}

module "ec2_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "~> 2.0"
  name                        = var.instance_name
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = var.is_public_instance
  user_data                   = var.user_data
  subnet_id                   = var.is_public_instance ? module.vpc.public_subnets[0] : module.vpc.private_subnets[0]
  vpc_security_group_ids = [
    module.instance_sg.this_security_group_id
  ]
  iam_instance_profile = module.instance_role.this_iam_instance_profile_name
  # Explicit dependencies on full modules so that they are ready before instance attempts to register with Systems manager
  depends_on = [
    module.vpc,
    module.instance_role,
    module.instance_sg,
    module.endpoint_sg
  ]
}

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/ansible/hosts.tpl",
    {
      instance_id = module.ec2_instance.id[0]
    }
  )
  filename = "${path.module}/ansible/hosts.yml"
}