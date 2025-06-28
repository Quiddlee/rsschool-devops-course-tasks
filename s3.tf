resource "aws_s3_bucket" "rsschool_bucket" {
  bucket = "${var.project_name}-${var.environment}"
}

resource "aws_s3_bucket_versioning" "rsschool_bucket_versioning" {
  bucket = aws_s3_bucket.rsschool_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "rsschool_bucket_encryption" {
  bucket = aws_s3_bucket.rsschool_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
