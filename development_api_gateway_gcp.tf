module "development_api_gateway_google" {
  source          = "./modules/google/api_gateway"
  name            = "development-api"
  create_neg      = true
  region          = local.google_region
  openapi_content = <<EOF
swagger: '2.0'
info:
  title: development-${local.project_name}
  version: 1.0.0
schemes:
  - https
paths:
  /api/{path=**}:
    get:
      parameters:
        - in: path
          name: path
          type: string
          required: true
      x-google-backend:
        address: ${module.cloud_run.service_url}
        path_translation: APPEND_PATH_TO_ADDRESS
      summary: Frontend proxy
      operationId: get-static
      responses:
        "200":
          description: Static file from Google Storage
EOF
}
