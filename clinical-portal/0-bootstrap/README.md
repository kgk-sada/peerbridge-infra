Prerequisites

To run the commands described in this document, install the following:

Google Cloud SDK version 393.0.0 or later
Git version 2.28.0 or later
Terraform version 1.3.0
Note: Make sure that you use version 1.3.0 of Terraform throughout this series. Otherwise, you might experience Terraform state snapshot lock errors.

Also make sure that you've done the following:

Set up a Google Cloud organization.
Set up a Google Cloud billing account.
Create Cloud Identity or Google Workspace groups for organization and billing admins.
Add the user who will use Terraform to the group_org_admins group. They must be in this group, or they won't have roles/resourcemanager.projectCreator access.
For the user who will run the procedures in this document, grant the following roles:
. The roles/resourcemanager.organizationAdmin role on the Google Cloud organization.
. The roles/orgpolicy.policyAdmin role on the Google Cloud organization.
. The roles/billing.admin role on the billing account.
. The roles/resourcemanager.folderCreator role.
If other users need to be able to run these procedures, add them to the group represented by the org_project_creators variable. For more information about the permissions that are required, and the resources that are created, see the organization bootstrap module documentation.


export GOOGLE_IMPERSONATE_SERVICE_ACCOUNT=