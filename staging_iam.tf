module "iam_policy_staging_lambda" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=v5.17.1"

  name        = "staging-${local.project_name}-lambda"
  path        = "/${local.project_name}/"
  description = "[staging] ${local.project_name} Lamdba policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "logs:PutLogEvents",
          "logs:CreateLogStream",
          "logs:CreateLogGroup"
        ],
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/staging-${local.project_name}-*:*:*",
          "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/staging-${local.project_name}-*:*",
        ]
      },
      {
        "Action" : [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ],
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:${local.project_name}/staging-*",
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : "secretsmanager:ListSecrets",
        "Resource" : "*"
      }
    ]
  })

  tags = local.staging_tags
}

resource "aws_iam_role" "staging_lambda" {
  name        = "staging-${local.project_name}-lambda"
  path        = "/${local.project_name}/"
  description = "[staging] ${local.project_name} Lamdba policy"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = ["lambda.amazonaws.com", "apigateway.amazonaws.com"]
        }
      },
    ]
  })

  managed_policy_arns = [
    module.iam_policy_staging_lambda.arn
  ]

  tags = local.staging_tags
}
