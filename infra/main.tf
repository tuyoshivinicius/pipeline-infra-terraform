terraform {
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0.0"
    }
  }
}

provider "aws" {
  region = local.region
}

# resources

resource "aws_sns_topic" "user_updates" {
  name = "user-updates-topic"
}