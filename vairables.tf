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
