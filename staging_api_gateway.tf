data "aws_lambda_function" "staging_backend" {
  function_name = "staging-${local.project_name}-backend"
}

module "staging_api_gateway" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-apigateway-v2.git?ref=v2.2.2"

  name          = "staging-${local.project_name}-gateway"
  description   = "[staging] ${local.project_name} API Gateway"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  # Custom domain
  domain_name                  = local.staging_domain_name
  domain_name_certificate_arn  = aws_acm_certificate.wildcard.arn
  create_api_domain_name       = true
  disable_execute_api_endpoint = true

  #   # Access logs
  #   default_stage_access_log_destination_arn = "arn:aws:logs:eu-west-1:835367859851:log-group:debug-apigateway"
  #   default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"

  # Routes and integrations
  integrations = {
    "POST /api/v1/basic" = {
      lambda_arn             = data.aws_lambda_function.staging_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Basic Auth)"
    }
    "GET /api/v1/google" = {
      lambda_arn             = data.aws_lambda_function.staging_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Google Auth)"
    }
    "GET /api/v1/google_callback" = {
      lambda_arn             = data.aws_lambda_function.staging_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Google Auth)"
    }
    "GET /api/v1/keycloak" = {
      lambda_arn             = data.aws_lambda_function.staging_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Keycloak Auth)"
    }
    "GET /api/v1/keycloak_callback" = {
      lambda_arn             = data.aws_lambda_function.staging_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Keycloak Auth)"
    }
    "GET /api/v1/apple" = {
      lambda_arn             = data.aws_lambda_function.staging_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Apple Auth)"
    }
    "GET /api/v1/apple_callback" = {
      lambda_arn             = data.aws_lambda_function.staging_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Apple Auth)"
    }
    "POST /api/v1/refresh-token" = {
      lambda_arn             = data.aws_lambda_function.staging_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Refresh Token)"
    }
    "GET /api/v1/logout" = {
      lambda_arn             = data.aws_lambda_function.staging_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Logout)"
    }
    "ANY /admin" = {
      lambda_arn             = data.aws_lambda_function.staging_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend API Docs"
      authorizer_key         = "auth-function"
      authorization_type     = "CUSTOM"
    }
    "GET /docs" = {
      lambda_arn             = data.aws_lambda_function.staging_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend API Docs"
      authorizer_key         = "auth-function"
      authorization_type     = "CUSTOM"
    }
    "GET /redoc" = {
      lambda_arn             = data.aws_lambda_function.staging_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend API Docs"
      authorizer_key         = "auth-function"
      authorization_type     = "CUSTOM"
    }
    "GET /openapi.json" = {
      lambda_arn             = data.aws_lambda_function.staging_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend API Docs"
      authorizer_key         = "auth-function"
      authorization_type     = "CUSTOM"
    }
    "ANY /api/v1/{proxy+}" = {
      lambda_arn             = data.aws_lambda_function.staging_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      authorizer_key         = "auth-function"
      authorization_type     = "CUSTOM"
      description            = "Backend function proxy"
    }
    "GET /{file+}" = {
      description          = "S3 frontend proxy"
      integration_type     = "HTTP_PROXY"
      integration_uri      = "http://${module.s3_bucket_staging_frontend.s3_bucket_website_endpoint}/{file}"
      timeout_milliseconds = 30 * 1000
      integration_method   = "GET"
    }
  }

  #   "$default" = {
  #     # lambda_arn = "arn:aws:lambda:eu-west-1:052235179155:function:my-default-function"
  #   }
  # }

  authorizers = {
    "auth-function" = {
      authorizer_type                   = "REQUEST"
      authorizer_uri                    = data.aws_lambda_function.staging_backend.invoke_arn
      identity_sources                  = ["$request.header.Authorization"]
      name                              = "staging-${local.project_name}-authorizer"
      authorizer_payload_format_version = "2.0"
    }
  }

  tags = {
    environment = "staging"
    project     = local.project_name
  }
}

resource "aws_apigatewayv2_domain_name" "extra_staging_domain_name" {
  domain_name = local.extra_staging_domain_name

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.extra_wildcard.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  tags = {
    environment = "staging"
    project     = local.project_name
  }
}

resource "aws_apigatewayv2_api_mapping" "extra_staging_domain_name" {
  api_id      = module.staging_api_gateway.apigatewayv2_api_id
  domain_name = aws_apigatewayv2_domain_name.extra_staging_domain_name.id
  stage       = module.staging_api_gateway.default_apigatewayv2_stage_id
}
