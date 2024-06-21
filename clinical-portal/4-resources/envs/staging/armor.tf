resource "google_compute_security_policy" "policy" {
  name    = var.armor_name 
  project = local.application_project_id
  
  rule {
    action   = "deny(403)"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }
  
  rule {
     description = "deny traffic from specific regions"
     action = "deny(403)"
     priority = "100"
     match {
        expr {
          expression = "origin.region_code == \"CN\" || origin.region_code == \"RU\" || origin.region_code == \"MM\" || origin.region_code == \"VN\" || origin.region_code == \"KP\""
        }
      }
    }
    
  rule {
      description = "allow all traffic"
      action = "allow"
      priority = "101"
      match {
        versioned_expr = "SRC_IPS_V1"
        config {
          src_ip_ranges = ["*"]
        }
      }
    }

}