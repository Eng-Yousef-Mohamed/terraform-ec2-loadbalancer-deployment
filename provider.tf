terraform {

  required_providers {
    aws = {
      
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
  
  #   backend "s3" {
  #   bucket         = "terraform-state-s3-yousef"  # Replace with your bucket name
  #   key            = "state.tfstate"  # Path within the bucket
  #   region         = "eu-north-1"  # Replace with your bucket's region
  #   dynamodb_table = "terraform_state"  # Optional: For state locking and consistency
  # }

}

provider "aws" {
  shared_config_files = [ "~/.aws/config" ]
  shared_credentials_files = [ "~/.aws/credentials" ]
}

