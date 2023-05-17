locals {
  gitlab_terraform_bucket_name = "${local.project_name}-terraform-state"
}

module "s3_bucket_gitlab_terraform" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git?ref=v3.10.1"

  bucket                   = local.gitlab_terraform_bucket_name
  block_public_acls        = true
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
          "arn:aws:s3:::${local.gitlab_terraform_bucket_name}",
          "arn:aws:s3:::${local.gitlab_terraform_bucket_name}/*",
        ]
      }
    ]
  })
}
