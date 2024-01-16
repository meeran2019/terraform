provider "aws" {
  assume_role {
    role_arn           = "arn:aws:iam::xxxx:role/tf-role"
    session_name       = "AssumeRoleSession"    
  }
}

provider "aws" {
  region = "us-east-1"
}
