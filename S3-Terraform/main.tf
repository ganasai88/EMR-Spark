resource "aws_s3_bucket" "example" {
  bucket = "emrterraform"

  tags = {
    Name        = "EMR-Terraform"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.example.id
  acl    = "public-read-write" # Use "private" if public access isn't necessary
}

resource "aws_s3_bucket_policy" "example_policy" {
  bucket = aws_s3_bucket.example.id
  policy = data.aws_iam_policy_document.example_policy.json
}

data "aws_iam_policy_document" "example_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::767398001187:user/EMR-Cluster"
      ]
    }

    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.example.arn,
      "${aws_s3_bucket.example.arn}/*"
    ]
  }
}
