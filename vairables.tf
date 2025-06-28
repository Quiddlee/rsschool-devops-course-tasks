variable "aws_region" {
  type        = string
  default     = "eu-north-1"
  description = "AWS region"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment name"
}

variable "project_name" {
  type        = string
  default     = "rsschool-devops-course"
  description = "Project name"
}

variable "all_ipv4_cidrs" {
  type        = string
  default     = "0.0.0.0/0"
  description = "Allows all IPv4 addresses"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets."
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "my_ip_cidr" {
  description = "A public IP address in CIDR notation"
  type        = string
  # No default here. Terraform will prompt you or expect a .tfvars file.
}
