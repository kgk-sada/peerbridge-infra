org_id = "755026064270" #REPLACE

billing_account = "01E279-B4BA55-B3E04E" #REPLACE

group_org_admins = "gcp-organization-admins@cormdx.com"

group_billing_admins = "gcp-billing-admins@cormdx.com"

default_region = "us-central1"

parent_folder = "1053940584849" #REPLACE

groups = {
  create_groups   = true,
  billing_project = "prj-billing-1", #REPLACE
  required_groups = {
    group_org_admins           = "gcp-organization-admin@cormdx.com"
    group_billing_admins       = "gcp-billing-admin@cormdx.com"
    billing_data_users         = "gcp-billing-user@cormdx.com"
    gcp_network_admins         = "gcp-network-admin@cormdx.com"
    monitoring_workspace_users = "gcp-monitoring-admin@cormdx.com"
  }
}
