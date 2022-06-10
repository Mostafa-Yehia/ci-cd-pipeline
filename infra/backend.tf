terraform {
  backend "s3" {
    bucket = "infra-tfstate"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "my-dynamodb"
  }
}