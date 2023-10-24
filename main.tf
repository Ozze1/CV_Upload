terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.74.2"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "eu-north-1" 
}
 
resource "aws_s3_bucket" "mybucket" {
  bucket = "osama-cv-bucket"

  tags = {
    Name        = "My bucket"
  }

}

resource "aws_s3_bucket_object" "example" {
  bucket = aws_s3_bucket.mybucket.id
  key = "Osama_Beshir-CV.pdf" # Set the desired key (object path)
  source = "/Users/osama/Documents/Osama_Beshir-CV.pdf"  # Set the local file path to upload
  acl = "private"
}

resource "aws_s3_bucket_public_access_block" "mybucket-public-access-block" {
  bucket = aws_s3_bucket.mybucket.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

/* 
# Create an S3 bucket policy to allow public read access through the VPC endpoint
resource "aws_s3_bucket_policy" "mybucket-policy" {
  bucket = aws_s3_bucket.mybucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "${aws_s3_bucket.mybucket.arn}/*"
    }
  ]
}
EOF
} */