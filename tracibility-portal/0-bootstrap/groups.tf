# retrieves organization information from Google Cloud
data "google_organization" "org" {
  count        = var.groups.create_groups ? 1 : 0
  organization = var.org_id
}

# module creates required Google Cloud groups based on the filtered list
module "required_group" {
  source               = "terraform-google-modules/group/google"
  version              = "~> 0.4"
  for_each             = var.groups.required_groups
  id                   = each.value.email
  display_name         = each.value.name
  initial_group_config = var.initial_group_config
  customer_id          = data.google_organization.org[0].directory_customer_id
}