locals {
  organization_id = local.parent_folder != "" ? null : local.org_id
  folder_id       = local.parent_folder != "" ? local.parent_folder : null
  policy_for      = local.parent_folder != "" ? "folder" : "organization"

  essential_contacts_domains_to_allow = concat(
    [for domain in var.essential_contacts_domains_to_allow : domain if can(regex("^@.*$", domain)) == true],
    [for domain in var.essential_contacts_domains_to_allow : "@${domain}" if can(regex("^@.*$", domain)) == false]
  )

  boolean_type_organization_policies = toset([
    "compute.disableNestedVirtualization",
    "compute.disableSerialPortAccess",
    "compute.disableGuestAttributesAccess",
    "compute.skipDefaultNetworkCreation",
    "compute.restrictXpnProjectLienRemoval",
    "compute.disableVpcExternalIpv6",
    "sql.restrictPublicIp",
    # "sql.restrictAuthorizedNetworks",
    # "iam.disableServiceAccountKeyCreation",
    "iam.disableServiceAccountKeyUpload",
    "storage.uniformBucketLevelAccess",
    "storage.publicAccessPrevention"
  ])

  private_pools = []
}

module "organization_policies_type_boolean" {
  source   = "terraform-google-modules/org-policy/google"
  version  = "~> 5.1"
  for_each = local.boolean_type_organization_policies

  organization_id = local.organization_id
  folder_id       = local.folder_id
  policy_for      = local.policy_for
  policy_type     = "boolean"
  enforce         = "true"
  constraint      = "constraints/${each.value}"
}

module "restrict_protocol_fowarding" {
  source  = "terraform-google-modules/org-policy/google"
  version = "~> 5.1"

  organization_id   = local.organization_id
  folder_id         = local.folder_id
  policy_for        = local.policy_for
  policy_type       = "list"
  allow             = ["INTERNAL"]
  allow_list_length = 1
  constraint        = "constraints/compute.restrictProtocolForwardingCreationForTypes"
}