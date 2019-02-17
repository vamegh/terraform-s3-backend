data "aws_caller_identity" "current" {}

terraform {
  required_version = ">= 0.11.11"
}

resource "aws_s3_bucket" "state_bucket" {
  bucket = "terraform-state-${data.aws_caller_identity.current.account_id}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags {
    Name = "terraform-state-${data.aws_caller_identity.current.account_id}"
  }
}

resource "aws_dynamodb_table" "state_locking_table" {
  name           = "terraform-state-${data.aws_caller_identity.current.account_id}"
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

  tags {
    Name = "terraform-state-${data.aws_caller_identity.current.account_id}"
  }
}
