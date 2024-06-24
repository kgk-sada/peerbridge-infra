# Must include the domain of the organization you are deploying the foundation.
domains_to_allow = ["cormdx.com"]

essential_contacts_domains_to_allow = ["cormdx.com"]

billing_data_users = "gcp-billing-user@cormdx.com"

gcp_groups = {
  network_admin    = "gcp-network-admin@cormdx.com"
  monitoring_users = "gcp-monitoring-admin@cormdx.com"
}

remote_state_bucket = "bkt-prj-b-seed-tfstate-163b" #REPLACE

network_admin_roles = ["roles/compute.networkAdmin", "roles/dns.admin", "roles/compute.orgSecurityResourceAdmin", "roles/compute.orgSecurityPolicyAdmin"]