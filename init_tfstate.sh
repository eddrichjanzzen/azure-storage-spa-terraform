# Script to create the terraform tfstate in azure storage
az group create -g terraform-states -l southeastasia
az storage account create -n ststaticsiteterraform001 -g  terraform-states -l southeastasia --sku Standard_LRS
az storage container create -n terraform-state --account-name ststaticsiteterraform001