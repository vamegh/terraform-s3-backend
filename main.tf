data "aws_caller_identity" "current" {}

terraform {
  required_version = ">= 0.12"
}

resource "aws_s3_bucket" "state_bucket" {
  bucket = local.name
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name = local.name
  }
}

resource "aws_dynamodb_table" "state_locking_table" {
  name           = local.name
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  tags = {
    Name = local.name
  }
}
