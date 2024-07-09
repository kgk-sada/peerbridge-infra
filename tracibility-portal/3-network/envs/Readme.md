Terraform Configuration for Network Infrastructure

This Terraform project is used to manage and provision network resources for different environments within our organization's infrastructure. Below is a brief description of each Terraform file in the dev, prod, and staging directories.

Environments
dev, prod, staging, training

Files

backend.tf: Configures the remote backend for storing the Terraform state files for the development environment.
firewall.tf: Manages firewall rules and configurations for the development environment.

main.tf: The main entry point for the development environment's Terraform configuration.

networks.tf: Defines network resources, such as VPCs and subnets, for the development environment.

outputs.tf: Specifies the output values for the development environment.

terraform.tfvars: Contains the variable values specific to the development environment.

variables.tf: Declares the variables used in the development environment's Terraform configuration.

Usage
1.Initialize Terraform:            terraform init
2.Plan the infrastructure changes: terraform plan
3.Apply the changes:               terraform apply

