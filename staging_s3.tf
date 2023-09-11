locals {
  staging_s3_buckets = toset([
    "${local.project_name}-frontend-app-client-staging",
    "${local.project_name}-frontend-app-admin-staging",
    "${local.project_name}-frontend-landing-staging",
  ])
}

module "s3_bucket_staging_frontend" {
  for_each = local.staging_s3_buckets
  source   = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git?ref=v3.10.1"

  bucket                  = each.key
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
          "arn:aws:s3:::${each.key}",
          "arn:aws:s3:::${each.key}/*",
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
          "arn:aws:s3:::${each.key}/*",
          "arn:aws:s3:::${each.key}",
        ]
      },
    ]
  })

  tags = local.staging_tags
}
