resource "aws_s3_bucket" "tfstate_bucket_umbrella" {
  bucket = "tfstate-bucket-umbrella-${var.owner}"
  acl    = "private"

  tags = {
    Name  = "tfstate-bucket-umbrella-${var.owner}"
    owner = var.owner
  }
}