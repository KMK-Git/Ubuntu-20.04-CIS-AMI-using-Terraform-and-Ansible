variable "vpc_name" {
  type        = string
  description = "Name to be used on all the VPC resources as identifier"
  default     = ""
}

variable "sg_name" {
  type        = string
  description = "Name of security group"
  default     = ""
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "vpc_azs" {
  type        = list(string)
  description = "A list of availability zones names or ids in the region"
}

variable "vpc_private_subnet" {
  type        = string
  description = "Private subnet inside the VPC. Use for EC2 instance"
}

variable "vpc_public_subnet" {
  type        = string
  description = "Public subnets inside the VPC. Used for NAT Gateway"
}

variable "iam_role_name" {
  type        = string
  description = "IAM role name"
  default     = ""
}

variable "instance_type" {
  type        = string
  description = "The type of instance to start"
  default     = "t2.micro"
}

variable "instance_name" {
  type        = string
  description = "Name to be used on all EC2 resources as prefix"
  default     = ""
}

variable "user_data" {
  type        = string
  description = "The user data to provide when launching the instance."
  default     = ""
}