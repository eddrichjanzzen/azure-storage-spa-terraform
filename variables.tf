variable "primary_region" {
  type = string
  description = "Required - the primary_region for the azure resource"
}

variable "cdn_region" {
  type = string
  description = "Required - the cdn_region for the azure resource"
}

variable "project_resource_group_name" {
  type = string
  description = "Required - the name of the projects resource group for the static site. You can import this if the target resource group already exists."
}

variable "static_site_storage_account_name" {
  type = string
  description = "Required - the name of the storage account for the static site"
}

variable "cdn_profile_name" {
  type = string
  description = "Required - the cdn_profile_name for the static site"
}

variable "cdn_endpoint_name" {
  type = string
  description = "Required - the cdn_endpoint_name for the static site"
}

variable "cdn_endpoint_origin_name" {
  type = string
  description = "Required - the cdn_endpoint_origin_name for the static site"
}
