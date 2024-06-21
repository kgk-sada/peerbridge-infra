locals {
  required_groups_to_create = {
    for key, value in var.groups.required_groups : key => value
    if var.groups.create_groups == true
  }
}

data "google_organization" "org" {
  count        = var.groups.create_groups ? 1 : 0
  organization = var.org_id
}

module "required_group" {
  source               = "terraform-google-modules/group/google"
  version              = "~> 0.4"
  for_each             = local.required_groups_to_create
  id                   = each.value
  display_name         = each.key
  description          = each.key
  initial_group_config = var.initial_group_config
  customer_id          = data.google_organization.org[0].directory_customer_id
}