variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "The routing mode of VPC"
}

variable "project_id" {
  type        = string
  description = "The project ID for VPC"
}

variable "network_name" {
  type        = string
  description = "The Name of VPC to create"
}

variable "subnets" {
  type        = list(map(string))
  description = "Subnets to be created"
}

variable "default_region" {
  type        = string
  description = "The default region to deploy"
}

variable "environment_code" {
  type        = string
  description = "The environment code to use"
}

variable "nat_bgp_asn" {
  type        = number
  description = "BGP ASN for first NAT cloud routes."
  default     = 64514
}

variable "nat_num_addresses_region" {
  type        = number
  description = "Number of external IPs to reserve for first Cloud NAT."
  default     = 1
}

variable "nat_enabled" {
  type        = bool
  description = "Check if NAT need to be created"
}

variable "router_log_filter" {
  type        = string
  description = "The configuration of logs filter"
}

variable "router_log_enabled" {
  type        = bool
  description = "Enabling logs for router"
}

variable "secondary_ranges" {
  description = "Secondary ranges for subnets"
}
