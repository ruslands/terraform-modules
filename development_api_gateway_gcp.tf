data "google_cloud_run_service" "development_backend" {
  name     = "development-backend"
  location = local.google_region
}

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
x-google-endpoints:
  - name: https://development.allpapers.online
    allowCors: True
x-google-backend:
  address: ${data.google_cloud_run_service.development_backend.status[0].url}
  path_translation: APPEND_PATH_TO_ADDRESS
  deadline: 5.0
paths:
  /api/v1/{path=**}:
    get:
      parameters:
        - in: path
          name: path
          type: string
          required: true
      operationId: api-get
      security: []
      responses:
        "200":
          description: OK
    post:
      parameters:
        - in: path
          name: path
          type: string
          required: true
      operationId: api-post
      security: []
      responses:
        "200":
          description: OK
    delete:
      parameters:
        - in: path
          name: path
          type: string
          required: true
      operationId: api-delete
      security: []
      responses:
        "200":
          description: OK
    patch:
      parameters:
        - in: path
          name: path
          type: string
          required: true
      operationId: api-patch
      security: []
      responses:
        "200":
          description: OK
    options:
      parameters:
        - in: path
          name: path
          type: string
          required: true
      operationId: api-options
      security: []
      responses:
        '200':
          description: OK
  /admin:
    get:
      operationId: admin-get
      security: []
      responses:
        "200":
          description: OK
    post:
      operationId: admin-post
      security: []
      responses:
        "200":
          description: OK
    delete:
      operationId: admin-delete
      security: []
      responses:
        "200":
          description: OK
    patch:
      operationId: admin-patch
      security: []
      responses:
        "200":
          description: OK
    put:
      operationId: admin-put
      security: []
      responses:
        "200":
          description: OK
    options:
      operationId: admin-options
      security: []
      responses:
        "200":
          description: OK
  /docs:
    get:
      operationId: docs-get
      security: []
      responses:
        "200":
          description: OK
  /redoc:
    get:
      operationId: redoc-get
      security: []
      responses:
        "200":
          description: OK
  /openapi.json:
    get:
      operationId: openapi
      security: []
      responses:
        "200":
          description: OK
EOF
}
