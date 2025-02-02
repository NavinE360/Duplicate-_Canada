# DynamoDB Table for State Locking
resource "aws_dynamodb_table" "terraform_lock_table" {
  name         = "nav-terraform-lock-table" # Name of the table
  billing_mode = "PAY_PER_REQUEST"      # On-demand pricing

  # Define the primary key (partition key)
  attribute {
    name = "LockID"
    type = "S" # String type
  }

  # Define the key schema
  hash_key = "LockID"

  # Enable Point-in-Time Recovery (Optional for backups)
  point_in_time_recovery {
    enabled = true
  }

  # Tags for the table
  tags = {
    Name        = "Terraform Lock Table"
    Environment = "dev"
  }
}
