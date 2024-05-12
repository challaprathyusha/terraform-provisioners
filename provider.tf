terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.48.0"
    }
  }
  backend "s3" {
    bucket = "remote-state-prathyu-bucket"
    key    = "local-exec-ec2"
    region = "us-east-1"
    dynamodb_table  = "s3-remote-state-locking"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}