resource "google_folder" "env" {
  display_name = "${local.folder_prefix}-${var.env}"
  parent       = local.parent
}

resource "google_folder" "sub_folder" {
  depends_on   = [google_folder.env]
  for_each     = toset(var.sub_folder)
  display_name = each.key
  parent       = google_folder.env.name
}

resource "google_folder_iam_binding" "folder_roles" {
  folder   = resource.google_folder.env.id
  for_each = var.iam_roles_group_pb_tp_prod_group
  role     = each.key
  members  = ["group:${local.prod_group}"]
}