variable "aws_region" {
  description = "AWS Region where the S3 bucket will be created."
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Project name used for resource naming and tags."
  type        = string
  default     = "vyomanant-cicd"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "dev"
}
