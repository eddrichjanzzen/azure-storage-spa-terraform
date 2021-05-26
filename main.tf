# empty block for the existing resource group
resource "azurerm_resource_group" "rg" {
  name = var.project_resource_group_name
  location = var.primary_region
}

resource "azurerm_storage_account" "site_storage" {
  name                     = var.static_site_storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document     = "index.html"
  }
}

resource "azurerm_cdn_profile" "cdn" {
  name                = var.cdn_profile_name
  location            = var.cdn_region
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Microsoft"
}


resource "azurerm_cdn_endpoint" "cdn_static_site" {
  name                = var.cdn_endpoint_name
  profile_name        = azurerm_cdn_profile.cdn.name
  location            = azurerm_cdn_profile.cdn.location
  resource_group_name = azurerm_resource_group.rg.name
  origin_host_header  = azurerm_storage_account.site_storage.primary_web_host

  origin {
    name      = var.cdn_endpoint_origin_name
    host_name = azurerm_storage_account.site_storage.primary_web_host
  }

  # enforce https
  delivery_rule {
    name  = "EnforceHTTPS"
    order = "1"

    request_scheme_condition {
      operator     = "Equal"
      match_values = ["HTTP"]
    }

    url_redirect_action {
      redirect_type = "Found"
      protocol      = "Https"
    }
  }

  # url rewrite for SPAs
 delivery_rule {
    name  = "SpaRewrite"
    order = "2"
    
    url_file_extension_condition {
      operator = "LessThan"
      match_values = ["1"]
    }

    url_rewrite_action {
      source_pattern = "/."
      destination = "/index.html"
    }

    modify_response_header_action {
      action = "Overwrite"
      name = "Cache-Control"
      value= "no-cache"
    }

    cache_expiration_action {
      behavior = "Override"
      duration = "0.00:05:00"
    }

  }


}