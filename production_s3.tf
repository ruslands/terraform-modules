
locals {
  production_s3_bucket_name = "production-${local.project_name}-frontend"
}

module "s3_bucket_production_frontend" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git?ref=v3.10.1"

  bucket                  = local.production_s3_bucket_name
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
  website = {
    index_document = "index.html"
    error_document = "index.html"
  }
  control_object_ownership = false
  attach_policy            = true
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "readwrite",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "${module.iam_user_gitlab_terraform.iam_user_arn}",
          ]
        },
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject",
        ],
        "Resource" : [
          "arn:aws:s3:::${local.production_s3_bucket_name}",
          "arn:aws:s3:::${local.production_s3_bucket_name}/*",
        ]
      },
      {
        "Sid" : "publicread",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : [
          "s3:GetObject",
        ]
        "Resource" : [
          "arn:aws:s3:::${local.production_s3_bucket_name}/*",
          "arn:aws:s3:::${local.production_s3_bucket_name}",
        ]
      },
    ]
  })

  tags = {
    environment = "production"
    project     = local.project_name
  }
}
