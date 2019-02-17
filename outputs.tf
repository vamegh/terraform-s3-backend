output "state_bucket_name" {
  value = "${aws_s3_bucket.state_bucket.id}"
}

output "state_table_name" {
  value = "${aws_dynamodb_table.state_locking_table.id}"
}

output "state_table_arn" {
  value = "${aws_dynamodb_table.state_locking_table.arn}"
}
