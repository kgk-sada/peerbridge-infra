# Must include the domain of the organization you are deploying the foundation.
domains_to_allow = ["cormdx.com"]

essential_contacts_domains_to_allow = ["cormdx.com"]

billing_data_users = "gcp-billing-user@cormdx.com"

gcp_groups = {
  network_admin    = "gcp-network-admin@cormdx.com"
  monitoring_users = "gcp-monitoring-admin@cormdx.com"
}

remote_state_bucket = "bkt-prj-b-seed-tfstate-76d3" #REPLACE

project_budget = {
  org_secrets_budget_amount             = 1000
  org_secrets_alert_spent_percents      = [0.5, 0.75, 0.9, 0.95]
  org_billing_logs_budget_amount        = 1000
  org_billing_logs_alert_spent_percents = [0.5, 0.75, 0.9, 0.95]
  org_audit_logs_budget_amount          = 1000
  org_audit_logs_alert_spent_percents   = [0.5, 0.75, 0.9, 0.95]
}

network_admin_roles = ["roles/compute.networkAdmin", "roles/dns.admin", "roles/compute.orgSecurityResourceAdmin", "roles/compute.orgSecurityPolicyAdmin"]