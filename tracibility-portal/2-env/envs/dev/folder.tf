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