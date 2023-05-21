module "iam_user_gitlab_terraform" {
  source                = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-user?ref=v5.17.1"
  name                  = "${local.project_name}-gitlab-terraform"
  path                  = "/${local.project_name}/"
  create_iam_access_key = true
}

locals {
  gitlab_terraform_policies = toset([
    "AWSLambda_FullAccess",
    "CloudWatchFullAccess",
    "AmazonAPIGatewayAdministrator",
    "AmazonEC2ContainerRegistryPowerUser",
  ])
}

data "aws_iam_policy" "gitlab_terraform_policies" {
  for_each = local.gitlab_terraform_policies
  name     = each.key
}

resource "aws_iam_user_policy_attachment" "gitlab_terraform" {
  for_each   = local.gitlab_terraform_policies
  user       = module.iam_user_gitlab_terraform.iam_user_name
  policy_arn = data.aws_iam_policy.gitlab_terraform_policies[each.key].arn
}
