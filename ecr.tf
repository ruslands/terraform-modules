module "ecr_repository" {
  for_each = toset([
    "${local.project_name}-backend",
  ])
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ecr.git?ref=v1.6.0"

  repository_name = each.key
  repository_lambda_read_access_arns = [
    "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:development-${local.project_name}-*",
    "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:staging-${local.project_name}-*",
    "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:production-${local.project_name}-*",
  ]

  create_lifecycle_policy         = false
  repository_image_tag_mutability = "MUTABLE"
  repository_force_delete         = true

  tags = local.common_tags
}
