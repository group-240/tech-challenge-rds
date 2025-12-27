terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # Use a clear, compatible range. Adjust if you need a different major version.
      version = ">= 5.0.0, < 6.0.0"
    }
  }

  # ⚠️ BEST PRACTICE: Uncomment this block after creating the S3 bucket manually
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
