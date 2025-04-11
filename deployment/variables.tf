variable "aws_region" {
  default = "us-east-1"
}

variable "ecr_image_url" {
  description = "ECR image URL for the datetime API"
  type        = string
}
