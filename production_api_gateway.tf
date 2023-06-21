data "aws_lambda_function" "production_backend" {
  function_name = "production-${local.project_name}-backend"
}

module "production_api_gateway" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-apigateway-v2.git?ref=v2.2.2"

  name          = "production-${local.project_name}-gateway"
  description   = "[production] ${local.project_name} API Gateway"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  # Custom domain
  domain_name                  = local.production_domain_name
  domain_name_certificate_arn  = aws_acm_certificate.wildcard.arn
  create_api_domain_name       = true
  disable_execute_api_endpoint = true

  #   # Access logs
  #   default_stage_access_log_destination_arn = "arn:aws:logs:eu-west-1:835367859851:log-group:debug-apigateway"
  #   default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"

  # Routes and integrations
  integrations = {
    "POST /api/v1/auth/basic" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Basic Auth)"
    }
    "GET /api/v1/auth/google" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Google Auth)"
    }
    "GET /api/v1/auth/google/callback" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Google Auth)"
    }
    "GET /api/v1/auth/keycloak" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Keycloak Auth)"
    }
    "GET /api/v1/auth/keycloak/callback" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Keycloak Auth)"
    }
    "GET /api/v1/auth/apple" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Apple Auth)"
    }
    "GET /api/v1/auth/apple/callback" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Apple Auth)"
    }
    "POST /api/v1/auth/refresh-token" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Refresh Token)"
    }
    "GET /api/v1/auth/logout" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy (Logout)"
    }
    "GET /admin" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend API Admin"
      # authorizer_key         = "auth-function"
      # authorization_type     = "CUSTOM"
    }
    "POST /admin" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend API Admin"
      # authorizer_key         = "auth-function"
      # authorization_type     = "CUSTOM"
    }
    "DELETE /admin" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend API Admin"
      # authorizer_key         = "auth-function"
      # authorization_type     = "CUSTOM"
    }
    "PATCH /admin" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend API Admin"
      # authorizer_key         = "auth-function"
      # authorization_type     = "CUSTOM"
    }
    "PUT /admin" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend API Docs"
      # authorizer_key         = "auth-function"
      # authorization_type     = "CUSTOM"
    }
    "GET /docs" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend API Admin"
      # authorizer_key         = "auth-function"
      # authorization_type     = "CUSTOM"
    }
    "GET /redoc" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend API Admin"
      # authorizer_key         = "auth-function"
      # authorization_type     = "CUSTOM"
    }
    "GET /openapi.json" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend API Admin"
      # authorizer_key         = "auth-function"
      # authorization_type     = "CUSTOM"
    }
    "GET /api/v1/{proxy+}" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy"
      # authorizer_key         = "auth-function"
      # authorization_type     = "CUSTOM"
    }
    "POST /api/v1/{proxy+}" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy"
      # authorizer_key         = "auth-function"
      # authorization_type     = "CUSTOM"
    }
    "DELETE /api/v1/{proxy+}" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy"
      # authorizer_key         = "auth-function"
      # authorization_type     = "CUSTOM"
    }
    "PATCH /api/v1/{proxy+}" = {
      lambda_arn             = data.aws_lambda_function.production_backend.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30 * 1000
      description            = "Backend function proxy"
      # authorizer_key         = "auth-function"
      # authorization_type     = "CUSTOM"
    }
    "GET /app/{file+}" = {
      description          = "S3 frontend proxy"
      integration_type     = "HTTP_PROXY"
      integration_uri      = "http://${module.s3_bucket_production_frontend["${local.project_name}-frontend-app-client-production"].s3_bucket_website_endpoint}/{file}"
      timeout_milliseconds = 30 * 1000
      integration_method   = "GET"
    }
    "GET /admin/{file+}" = {
      description          = "S3 frontend proxy"
      integration_type     = "HTTP_PROXY"
      integration_uri      = "http://${module.s3_bucket_production_frontend["${local.project_name}-frontend-app-admin-production"].s3_bucket_website_endpoint}/{file}"
      timeout_milliseconds = 30 * 1000
      integration_method   = "GET"
    }
    "GET /media/{file+}" = {
      description          = "S3 media proxy"
      integration_type     = "HTTP_PROXY"
      integration_uri      = "http://${module.s3_bucket_media.s3_bucket_bucket_domain_name}/{file}"
      timeout_milliseconds = 30 * 1000
      integration_method   = "GET"
    }
    "GET /{file+}" = {
      description          = "S3 frontend proxy"
      integration_type     = "HTTP_PROXY"
      integration_uri      = "http://${module.s3_bucket_production_frontend["${local.project_name}-frontend-landing-production"].s3_bucket_website_endpoint}/{file}"
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
      authorizer_uri                    = data.aws_lambda_function.production_backend.invoke_arn
      identity_sources                  = ["$request.header.Authorization"]
      name                              = "production-${local.project_name}-authorizer"
      authorizer_payload_format_version = "2.0"
    }
  }

  tags = local.production_tags
}

resource "aws_apigatewayv2_domain_name" "extra_production_domain_name" {
  domain_name = local.extra_production_domain_name

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.extra_wildcard.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  tags = local.production_tags
}

resource "aws_apigatewayv2_api_mapping" "extra_production_domain_name" {
  api_id      = module.production_api_gateway.apigatewayv2_api_id
  domain_name = aws_apigatewayv2_domain_name.extra_production_domain_name.id
  stage       = module.production_api_gateway.default_apigatewayv2_stage_id
}
