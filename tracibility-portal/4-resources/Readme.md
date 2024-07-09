# GCP IaC Code

# Prerequisites

To run the commands described in this document, make sure you have the following installed:

- Google Cloud SDK version 393.0.0 or later
- Git version 2.28.0 or later
- Terraform version 1.3.0

**Note:** It is important to use version 1.3.0 of Terraform throughout this series to avoid Terraform state snapshot lock errors.

To create the environment from scratch, ensure that you have completed the following steps:

1. Set up a Google Cloud organization.
2. Set up a Google Cloud billing account.
3. Create Cloud Identity or Google Workspace groups for organization (`org_admin`) and billing admins(`bill_admin`).
4. If you want the following terraform configuration to apply at a folder level, make sure you've created the folder first by hand.
5. Create a GCP project for billing and enable the Cloud Identity API inside of it.
6. Add the user who will use Terraform to the `org_admin` group. This is necessary for them to have `roles/resourcemanager.projectCreator` access. If the user is not part of this group, they won't have the required access.
7. Grant the following roles to the user who will run the procedures in this document:
    - `roles/resourcemanager.organizationAdmin` on the Google Cloud organization
    - `roles/orgpolicy.policyAdmin` on the Google Cloud organization
    - `roles/billing.admin` on the billing account
    - `roles/storage.admin`
    - `roles/resourcemanager.folderCreator`
    - `roles/resourcemanager.projectCreator`
    - `roles/iam.serviceAccountTokenCreator` for being able to impersonate service accounts to run later steps of the code
8. If other users also need to be able to run these procedures, add them to the group represented by the `org_project_creators` variable.
   
For detailed information about the required permissions and the resources that will be created, refer to the documentation.

## Running the code

For the first instance

In order to implement the terraform configuration we will need to go through each folder one-by-one:
 - 0-bootstrap
 - 1-org
 - 2-env
 - 3-network
 - 4-reosurces

All of these folders are responsible for creating seperate steps of our project.

0-bootstrap creates the seed project, several groups, the service accounts needed to run the code as well as the terraform state backend in GCS.  

1-org is for setting up the folder structure, and IAM permissions for the groups under those folders.

2-env creates the projects within those folders, setting up logging, secrets and application projects. 

3-net sets up the VPCs, network connectivity and firewall for the application projects.

4-resources sets up the resources such as GKE, CloudSQL inside the application projects

To run the code, we start with going into the 0-bootstrap folder, make sure to login to our account for the gcloud cli tool using the `gcloud auth application-default login` command. 

After running that command, we can run `terraform init` for the first time to start setting up the local backend. If the configuration is all correct, running `terraform plan` will show us all the resources that will be created by terraform. After confirming the resources, we run `terraform apply` to create all of those resources. 

One important thing to note about the first 0-bootstrap folder is that it needs to be run twice; after everything is successfully created, we can change the terraform state bucket name to the one created in the `backend.tf` file and rerun `terraform init`. This will migrate the state from our local machine to the remote state. 