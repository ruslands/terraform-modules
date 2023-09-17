module "gcp_lb" {
  depends_on = [
    module.frontend_buckets_gcp
  ]
  source         = "./modules/google/lb"
  project        = local.google_project_id
  name           = "${local.project_name}-lb"
  ssl            = true
  https_redirect = true
  create_address = true
  managed_ssl_certificate_domains = [
    "development.allpapers.online"
  ]
  # TODO: use cert from Certificate Manager
  # certificate_map = module.certificate_gcp.certificate_map_id
  #   use_ssl_certificates = true
  #   ssl_certificates = [
  #     module.certificate_gcp.id
  #   ]

  url_map_config = {
    default_backend = "development-frontend-landing"
    host_rules = [
      {
        hosts = ["development.allpapers.online"]
        path_matcher = {
          name            = "development"
          default_backend = "development-frontend-landing"
          path_rules = [
            {
              paths   = ["/api/*", "/admin"]
              backend = "development-api"
            },
            {
              paths               = ["/console", "/console/*"]
              backend             = "development-frontend-app-admin"
              path_prefix_rewrite = "/"
            },
            {
              paths               = ["/app", "/app/*"]
              backend             = "development-frontend-app-client"
              path_prefix_rewrite = "/"
            },
            # {
            #   paths               = ["/media/*"]
            #   backend             = "media"
            #   path_prefix_rewrite = "/"
            # }
          ]
        }
      }
    ]
  }

  backends = {
    # media = {
    #   type        = "BUCKET"
    #   bucket_name = "${local.project_name}-media"
    # }
    development-frontend-landing = {
      type        = "BUCKET"
      bucket_name = "${local.project_name}-frontend-landing-development"
    }
    development-frontend-app-admin = {
      type        = "BUCKET"
      bucket_name = "${local.project_name}-frontend-app-admin-development"
    }
    development-frontend-app-client = {
      type        = "BUCKET"
      bucket_name = "${local.project_name}-frontend-app-client-development"
    }
    development-api = {
      type     = "NEG"
      protocol = "HTTPS"

      log_config = {
        enable      = true
        sample_rate = 1.0
      }

      groups = [
        {
          # Your serverless service should have a NEG created that's referenced here.
          group = module.development_api_gateway_google.neg_id
        }
      ]

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    }
  }
}
