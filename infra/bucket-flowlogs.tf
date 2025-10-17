resource "aws_s3_bucket" "tfstate_bucket_umbrella" {
  bucket = "tfstate-bucket-umbrella-${var.owner}"
  # acl    = "private"

  tags = {
    Name  = "tfstate-bucket-umbrella-${var.owner}"
    owner = var.owner
  }
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.tfstate_bucket_umbrella.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# resource "aws_s3_bucket_acl" "tfstate_bucket_umbrella_acl" {
#   bucket = aws_s3_bucket.tfstate_bucket_umbrella.id
#   acl    = "private"
# }