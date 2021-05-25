terraform {
    backend "azurerm" {
    resource_group_name  = "terraform-states"
    storage_account_name = "ststaticsiteterraform001"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}