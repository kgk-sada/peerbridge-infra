resource "google_compute_global_address" "lb" {
  name = "lb-ext-ip"
}

module "gce-lb-https" {
  source  = "terraform-google-modules/lb-http/google"
  version = "~> 10.0"
  name    = "xlb-7-https"
  project = local.application_project_id
  address = google_compute_global_address.lb.address
  create_address = false
  ssl = true
  http_forward = false
  managed_ssl_certificate_domains = ["cormdx.com"]
  firewall_networks = [local.network_self_link]
  firewall_projects = [local.network_project_id]
  backends = {
    default = {

      protocol    = "HTTP"
      port        = 80
      port_name   = "http"
      timeout_sec = 30
      enable_cdn  = false

      health_check = {
        # request_path = "/"
        protocol = "HTTP"
        port         = 80
      }

      log_config = {
        enable      = true
        sample_rate = 1.0
      }

      groups = [
        {
          group = google_compute_instance_group.dev_traceability_umig.self_link
        }
      ]

      iap_config = {
        enable = false
      }
    }
  }
}