resource "aws_s3_bucket" "one" {
  bucket = "eshu.flm-devops.bucket"
}

resource "aws_s3_bucket_ownership_controls" "two" {
  bucket = aws_s3_bucket.one.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "three" {
  depends_on = [aws_s3_bucket_ownership_controls.two]

  bucket = aws_s3_bucket.one.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "three" {
bucket = aws_s3_bucket.one.id
versioning_configuration {
status = "Enabled"
}
}

terraform {
  backend "s3" {
    bucket = "eshu.flm-devops.bucket"     # Specifies the name of the S3 bucket
    key    = "prod/terraform.tfstate"  # Specifies the path to the state file within the bucket
    region = "us-east-1"            # Specifies the AWS region where the S3 bucket is located
  }
}

