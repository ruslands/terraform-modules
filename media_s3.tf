locals {
  media_s3_bucket_name = "${local.project_name}-media"
}

module "s3_bucket_media" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git?ref=v3.10.1"

  bucket                   = local.media_s3_bucket_name
  block_public_acls        = false
  block_public_policy      = false
  ignore_public_acls       = false
  restrict_public_buckets  = false
  control_object_ownership = false
  attach_policy            = true
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "${module.iam_user_s3_media.iam_user_arn}",
          ]
        },
        "Action" : "*",
        "Resource" : [
          "arn:aws:s3:::${local.media_s3_bucket_name}",
          "arn:aws:s3:::${local.media_s3_bucket_name}/*",
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
          "arn:aws:s3:::${local.media_s3_bucket_name}/*",
          "arn:aws:s3:::${local.media_s3_bucket_name}",
        ]
      }
    ]
  })

  tags = local.common_tags
}
