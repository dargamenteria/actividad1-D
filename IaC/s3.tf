#resource "aws_s3_account_public_access_block" "s3_default_public_access" {
#  block_public_acls       = true
#  block_public_policy     = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#}


module "s3_server_anjana_buckets" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "~>4.1.2"
  for_each = toset(var.s3_bucket_names)
  bucket   = "${each.value}-${var.client_name}"
  #acl    = "private"
  control_object_ownership = true

  versioning = {
    status = false
  }
#  attach_policy           = true
#  block_public_policy     = true
#  block_public_acls       = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        bucket_key_enabled = true
        sse_algorithm      = "AES256"
      }
    }
  }
}
