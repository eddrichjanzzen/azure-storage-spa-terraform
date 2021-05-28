# General
output "project_resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "The name of the resource group account."
}

output "static_site_storage_account_name" {
  value       = azurerm_storage_account.site_storage.name
  description = "The name of the storage account."
}

output "cdn_endpoint_name" {
  value       = azurerm_cdn_endpoint.cdn_static_site.name
  description = "The name of the cdn endpoint."
}

output "cdn_profile_name" {
  value       = azurerm_cdn_profile.cdn.name
  description = "The name of the cdn profile."
}
