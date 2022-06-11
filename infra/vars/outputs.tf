data "aws_s3_bucket_object" "my_secret" {
  bucket = var.bucket
  key    = var.key
}

output my_secret {
  value = "${data.aws_s3_bucket_object.my_secret.body}"
}
