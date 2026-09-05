resource "random_id" "suffix" {
  byte_length = 3
}

locals {
  bucket_name = lower(
    join(
      "-",
      [
        var.project_name,
        var.environment,
        terraform.workspace,
        random_id.suffix.hex
      ]
    )
  )
}

resource "aws_s3_bucket" "lab_bucket" {
  bucket = local.bucket_name

  tags = {
    Name        = local.bucket_name
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Academy     = "Vyomanant Academy"
  }
}

resource "aws_s3_bucket_versioning" "lab_bucket" {
  bucket = aws_s3_bucket.lab_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "lab_bucket" {
  bucket = aws_s3_bucket.lab_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "lab_bucket" {
  bucket = aws_s3_bucket.lab_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
