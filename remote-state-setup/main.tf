terraform {

  required_providers {
    aws = {
      
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }

}

provider "aws" {
  shared_config_files = [ "~/.aws/config" ]
  shared_credentials_files = [ "~/.aws/credentials" ]
}

resource "aws_s3_bucket" "aws_bucket" {
  bucket = "terraform-state-s3-yousef"  # Replace with a unique bucket name

  tags = {
    Name        = "Terraform State Bucket"
 
  }
}
resource "aws_s3_bucket_acl" "acl" {
    bucket = aws_s3_bucket.aws_bucket.id
    acl    = "private"
  
}

resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.aws_bucket.id
    versioning_configuration {
      status = "Enabled"
    }

}

resource "aws_dynamodb_table" "db" {
    name = "terraform_state"
    billing_mode   = "PAY_PER_REQUEST"
    hash_key       = "LockID"
    
    attribute {
        name = "LockID"
        type = "S"
    } 

    tags = {
        "Name" = "DynamoDB Terraform State Lock Table"
    }
}