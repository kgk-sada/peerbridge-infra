env                              = "prod"
environment_code                 = "p"
env_billing_code                 = "prod"
remote_state_bucket              = "bkt-prj-b-seed-tfstate-163b"
monitoring_workspace_users       = "gcp-monitoring-admin@cormdx.com"
sub_folder                       = ["fldr-backend"]
iam_roles_group_pb_tp_prod_group = ["roles/iap.tunnelResourceAccessor", "roles/compute.instanceAdmin.v1", "roles/cloudsql.editor", "roles/storage.admin"]