/******************************************
  Top level folders
 *****************************************/

resource "google_folder" "common" {
  display_name = "${local.folder_prefix}-common"
  parent       = local.parent
}
