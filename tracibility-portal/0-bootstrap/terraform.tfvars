org_id = "755026064270" #REPLACE

billing_account = "01E279-B4BA55-B3E04E" #REPLACE

group_org_admins = "gcp-organization-admins@cormdx.com"

group_billing_admins = "gcp-billing-admins@cormdx.com"

default_region = "us-central1"

parent_folder = "208971481160" #REPLACE

groups = {
  create_groups   = true,
  billing_project = "prj-billing-tp", #REPLACE
  required_groups = {
    group_pb_tp_dev = {
      name = "group_pb_tp_dev"
      email = "gcp-pb-tp-dev@cormdx.com"
    }

    group_pb_tp_training  = {
      name = "group_pb_tp_training"
      email = "gcp-pb-tp-training@cormdx.com"
    }

    group_pb_tp_prod         ={
      name = "group_pb_tp_prod"
      email =  "gcp-pb-tp-prod@cormdx.com"
    }
    
    group_pb_tp_staging     = {
      name = "group_pb_tp_staging"
      email = "gcp-pb-tp-staging@cormdx.com"
    }

  }
}
