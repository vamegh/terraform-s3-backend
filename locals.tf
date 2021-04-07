locals {
  name = "terraform-state-${var.unique_id}-${data.aws_caller_identity.current.account_id}"
}

