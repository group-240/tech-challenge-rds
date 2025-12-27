terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # The VPC module used in this repo requires AWS provider v6.x (module v6.x).
      # Allow a compatible v6 range. If you intentionally need v5, pin the VPC module to v5.
      version = ">= 6.0.0, < 7.0.0"
    }
  }

  # BEST PRACTICE: Uncomment this block after creating the S3 bucket manually
  # backend "s3" {
  #   bucket         = "my-terraform-state-bucket"
  #   key            = "tech-challenge/db/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-locks"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "TechChallenge"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}
