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
  region = var.region
}

# resources

# SNS
resource "aws_sns_topic" "example" {
  name              = "example-topic"
  kms_master_key_id = "alias/kms-example-topic"
}

# data para pegar informações da conta
data "aws_caller_identity" "current" {}

# Criando S3 Bucket
resource "aws_s3_bucket" "meu_bucket" {
  bucket = "nome-do-meu-bucket"
}

# Criando Policy do bucket e attachando ao documento de policy
resource "aws_s3_bucket_policy" "meu_bucket_policy" {
  bucket = aws_s3_bucket.meu_bucket.id
  policy = data.aws_iam_policy_document.meu_bucket_policy_data.json
}
# Criando documento de policy
data "aws_iam_policy_document" "meu_bucket_policy_data" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }

    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.meu_bucket.arn,
      "${aws_s3_bucket.meu_bucket.arn}/*",
    ]
  }
}