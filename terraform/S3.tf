# S3 Bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = "nav-my-terraform-state-bucket" # Replace with your unique bucket name

  # Enable server-side encryption with KMS
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  # Tags for identification
  tags = {
    Name        = "Terraform State Bucket"
    Environment = "dev"
  }
}

# Enable versioning using aws_s3_bucket_versioning
resource "aws_s3_bucket_versioning" "mybucket_versioning" {
  bucket = aws_s3_bucket.mybucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Block public access to the bucket
resource "aws_s3_bucket_public_access_block" "mybucket_access" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Add an S3 bucket policy to restrict access
resource "aws_s3_bucket_policy" "mybucket_policy" {
  bucket = aws_s3_bucket.mybucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "DenyUnencryptedUploads",
        Effect    = "Deny",
        Principal = "*",
        Action    = "s3:PutObject",
        Resource  = "${aws_s3_bucket.mybucket.arn}/*",
        Condition = {
          StringNotEquals = {
            "s3:x-amz-server-side-encryption" = "aws:kms" # Matches KMS encryption
          }
        }
      }
    ]
  })
}

# KMS Key for Encryption
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}