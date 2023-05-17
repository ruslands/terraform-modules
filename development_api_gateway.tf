# data "aws_lambda_function" "development_auth" {
#   function_name = "development-${local.project_name}-auth"
# }

# data "aws_lambda_function" "development_core" {
#   function_name = "development-${local.project_name}-core"
# }

# module "development_api_gateway" {
#   source = "git::https://github.com/terraform-aws-modules/terraform-aws-apigateway-v2.git?ref=v2.2.2"

#   name          = "development-${local.project_name}-gateway"
#   description   = "[development] ${local.project_name} API Gateway"
#   protocol_type = "HTTP"

#   #   cors_configuration = {
#   #     allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
#   #     allow_methods = ["*"]
#   #     allow_origins = ["*"]
#   #   }

#   # Custom domain
#   domain_name                  = local.development_domain_name
#   domain_name_certificate_arn  = aws_acm_certificate.wildcard.arn
#   create_api_domain_name       = true
#   disable_execute_api_endpoint = true

#   #   # Access logs
#   #   default_stage_access_log_destination_arn = "arn:aws:logs:eu-west-1:835367859851:log-group:debug-apigateway"
#   #   default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"

#   # Routes and integrations
#   integrations = {
#     # "POST /api/auth/v1/auth/basic" = {
#     #   lambda_arn             = data.aws_lambda_function.development_auth.arn
#     #   payload_format_version = "2.0"
#     #   timeout_milliseconds   = 30 * 1000
#     #   description            = "Auth function proxy (Basic Auth)"
#     # }
#     # "GET /api/auth/v1/auth/google" = {
#     #   lambda_arn             = data.aws_lambda_function.development_auth.arn
#     #   payload_format_version = "2.0"
#     #   timeout_milliseconds   = 30 * 1000
#     #   description            = "Auth function proxy (Google Auth)"
#     # }
#     # "GET /api/auth/v1/auth/google_callback" = {
#     #   lambda_arn             = data.aws_lambda_function.development_auth.arn
#     #   payload_format_version = "2.0"
#     #   timeout_milliseconds   = 30 * 1000
#     #   description            = "Auth function proxy (Google Auth)"
#     # }
#     # "GET /api/auth/v1/auth/keycloak" = {
#     #   lambda_arn             = data.aws_lambda_function.development_auth.arn
#     #   payload_format_version = "2.0"
#     #   timeout_milliseconds   = 30 * 1000
#     #   description            = "Auth function proxy (Keycloak Auth)"
#     # }
#     # "GET /api/auth/v1/auth/keycloak_callback" = {
#     #   lambda_arn             = data.aws_lambda_function.development_auth.arn
#     #   payload_format_version = "2.0"
#     #   timeout_milliseconds   = 30 * 1000
#     #   description            = "Auth function proxy (Keycloak Auth)"
#     # }
#     # "GET /api/auth/v1/auth/apple" = {
#     #   lambda_arn             = data.aws_lambda_function.development_auth.arn
#     #   payload_format_version = "2.0"
#     #   timeout_milliseconds   = 30 * 1000
#     #   description            = "Auth function proxy (Apple Auth)"
#     # }
#     # "GET /api/auth/v1/auth/apple_callback" = {
#     #   lambda_arn             = data.aws_lambda_function.development_auth.arn
#     #   payload_format_version = "2.0"
#     #   timeout_milliseconds   = 30 * 1000
#     #   description            = "Auth function proxy (Apple Auth)"
#     # }
#     # "POST /api/auth/v1/auth/refresh-token" = {
#     #   lambda_arn             = data.aws_lambda_function.development_auth.arn
#     #   payload_format_version = "2.0"
#     #   timeout_milliseconds   = 30 * 1000
#     #   description            = "Auth function proxy (Refresh Token)"
#     # }
#     # "GET /api/auth/v1/auth/logout" = {
#     #   lambda_arn             = data.aws_lambda_function.development_auth.arn
#     #   payload_format_version = "2.0"
#     #   timeout_milliseconds   = 30 * 1000
#     #   description            = "Auth function proxy (Logout)"
#     # }
#     "ANY /auth/admin" = {
#       lambda_arn             = data.aws_lambda_function.development_auth.arn
#       payload_format_version = "2.0"
#       timeout_milliseconds   = 30 * 1000
#       description            = "Auth API Docs"
#       authorizer_key         = "auth-function"
#       authorization_type     = "CUSTOM"
#     }
#     "GET /auth/docs" = {
#       lambda_arn             = data.aws_lambda_function.development_auth.arn
#       payload_format_version = "2.0"
#       timeout_milliseconds   = 30 * 1000
#       description            = "Auth API Docs"
#       authorizer_key         = "auth-function"
#       authorization_type     = "CUSTOM"
#     }
#     "GET /auth/redoc" = {
#       lambda_arn             = data.aws_lambda_function.development_auth.arn
#       payload_format_version = "2.0"
#       timeout_milliseconds   = 30 * 1000
#       description            = "Auth API Docs"
#       authorizer_key         = "auth-function"
#       authorization_type     = "CUSTOM"
#     }
#     "GET /auth/openapi.json" = {
#       lambda_arn             = data.aws_lambda_function.development_auth.arn
#       payload_format_version = "2.0"
#       timeout_milliseconds   = 30 * 1000
#       description            = "Auth API Docs"
#       authorizer_key         = "auth-function"
#       authorization_type     = "CUSTOM"
#     }
#     "ANY /core/admin" = {
#       lambda_arn             = data.aws_lambda_function.development_core.arn
#       payload_format_version = "2.0"
#       timeout_milliseconds   = 30 * 1000
#       description            = "Core API Docs"
#       authorizer_key         = "auth-function"
#       authorization_type     = "CUSTOM"
#     }
#     "GET /core/docs" = {
#       lambda_arn             = data.aws_lambda_function.development_core.arn
#       payload_format_version = "2.0"
#       timeout_milliseconds   = 30 * 1000
#       description            = "Core API Docs"
#       authorizer_key         = "auth-function"
#       authorization_type     = "CUSTOM"
#     }
#     "GET /core/redoc" = {
#       lambda_arn             = data.aws_lambda_function.development_core.arn
#       payload_format_version = "2.0"
#       timeout_milliseconds   = 30 * 1000
#       description            = "Core API Docs"
#       authorizer_key         = "auth-function"
#       authorization_type     = "CUSTOM"
#     }
#     "GET /core/openapi.json" = {
#       lambda_arn             = data.aws_lambda_function.development_core.arn
#       payload_format_version = "2.0"
#       timeout_milliseconds   = 30 * 1000
#       description            = "Core API Docs"
#       authorizer_key         = "auth-function"
#       authorization_type     = "CUSTOM"
#     }
#     "ANY /api/auth/v1/{proxy+}" = {
#       lambda_arn             = data.aws_lambda_function.development_auth.arn
#       payload_format_version = "2.0"
#       timeout_milliseconds   = 30 * 1000
#       authorizer_key         = "auth-function"
#       authorization_type     = "CUSTOM"
#       description            = "Auth function proxy"
#     }
#     "ANY /api/core/v1/{proxy+}" = {
#       lambda_arn             = data.aws_lambda_function.development_core.arn
#       payload_format_version = "2.0"
#       timeout_milliseconds   = 30 * 1000
#       authorizer_key         = "auth-function"
#       authorization_type     = "CUSTOM"
#       description            = "Core function proxy"
#     }
#     "GET /{file+}" = {
#       description          = "S3 frontend proxy"
#       integration_type     = "HTTP_PROXY"
#       integration_uri      = "http://${module.s3_bucket_development_frontend.s3_bucket_website_endpoint}/{file}"
#       timeout_milliseconds = 30 * 1000
#       integration_method   = "GET"
#     }
#   }

#   #   "$default" = {
#   #     # lambda_arn = "arn:aws:lambda:eu-west-1:052235179155:function:my-default-function"
#   #   }
#   # }

#   authorizers = {
#     "auth-function" = {
#       authorizer_type                   = "REQUEST"
#       authorizer_uri                    = data.aws_lambda_function.development_auth.invoke_arn
#       identity_sources                  = ["$request.header.Authorization"]
#       name                              = "development-${local.project_name}-authorizer"
#       authorizer_payload_format_version = "2.0"
#     }
#   }

#   tags = {
#     environment = "development"
#   }
# }
