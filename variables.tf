variable "vpc_name" {
  type        = string
  description = "Name to be used on all the VPC resources as identifier"
  default     = ""
}

variable "sg_name" {
  type        = string
  description = "Name of security group"
  default     = ""
  sensitive   = true
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
  sensitive   = true
}

variable "vpc_azs" {
  type        = list(string)
  description = "A list of availability zones names or ids in the region"
}

variable "vpc_private_subnets" {
  type        = list(string)
  description = "A list of private subnets inside the VPC. First subnet in list is used if instance is private"
  default     = []
  sensitive   = true
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "A list of public subnets inside the VPC.  First subnet in list is used if instance is public"
  default     = []
  sensitive   = true
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
  sensitive   = true
}

variable "user_data" {
  type        = string
  description = "The user data to provide when launching the instance."
  default     = ""
  sensitive   = true
}

variable "is_public_instance" {
  type        = bool
  description = "Instance is accessible from the internet."
  default     = false
}