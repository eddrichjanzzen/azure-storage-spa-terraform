# About 
The purpose of this project is to automate the process for deploying static sites or SPAs using azure storage. There is also an azure cdn which supports the standard configuration for SPA rewrites. 

# Prequisites 
1. Terraform 
2. Azure Cli
3. An existing Azure subscription

# Set up 
Create your `terraform.state` in azure storage. 

In the root for this project, execute the following bash script: 

```
$ sh init_tfstate.sh
```
This script will create a resource group containing an azure storage account and azure container to store the terraform state. 

After the resources are done provisioning, initialize terraform as follows:
```
$ terraform init
```

# Usage
To provision your resources you can modify `terraform.tfvars`. In this file you can change the region, storage name, cdn configurations, etc, eg: 

```tf
# General

primary_region="southeastasia"
cdn_region="southeastasia"

# Resource group
project_resource_group_name="static-site"

# Storage
static_site_storage_account_name="ststaticsitesample001"

# CDN
cdn_profile_name="static-site-cdn-sample-001"
cdn_endpoint_name="static-site-cdn-sample-001"
cdn_endpoint_origin_name="static-site-cdn-sample-001"

```

# To deploy the resources into an existing resource group 

You must import the resource to the terraform state for terraform to keep track of the existing resource. You can do so with the following command: 

```bash
$ terraform import azurerm_resource_group.rg /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example
```
* Note that the `project_resource_group_name` in `terraform.tfvars` must match the name of the existing resource group in azure. For example, if your resource group name is called `static-site` the `project_resource_group_name` must also match this. 

```tf
project_resource_group_name="static-site"
```

  $ terraform import azurerm_resource_group.rg /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/**static-site**


# Run terraform commands

```bash
$ terraform plan
$ terrform apply
```


# Tear down 

```bash
$ terraform destroy
```

