Terraform Configuration for Multiple Environments

This Terraform project is used to manage and provision resources for multiple environments within our organization's infrastructure. Below is a brief description of each Terraform file in the dev, prod, and staging directories.

Environments
dev, prod, staging, training

Files
backend.tf: Configures the remote backend for storing the Terraform state files for the development environment.

folder.tf: Manages the creation and organization of folders specific to the development environment.

main.tf: The main entry point for the development environment's Terraform configuration.

output.tf: Specifies the output values for the development environment.

prj_application.tf: Manages application-specific resources for the development environment.

prj_monitoring.tf: Configures monitoring resources for the development environment.

prj_network_host.tf: Manages network hosting resources for the development environment.

terraform.tfvars: Contains the variable values specific to the development environment.

variables.tf: Declares the variables used in the development environment's Terraform configuration.

Usage
1.Initialize Terraform:            terraform init
2.Plan the infrastructure changes: terraform plan
3.Apply the changes:               terraform apply
