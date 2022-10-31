# Azure Dashboard Terraform Module

Dashboards are a focused and organized view of your cloud resources in the Azure portal. Use dashboards as a workspace where you can monitor resources and quickly launch tasks for day-to-day operations.

This terrafrom module quickly deploys multiple dashboards in an Azure resource group using json template files for dashboard definitions.

## Module Usage

```hcl
# Azurerm Provider configuration
provider "azurerm" {
  features {}
}

module "dashboard" {
  source  = "kumarvna/dashboard/azurerm"
  version = "1.1.0"

  # By default, this module will not create a resource group. Location will be same as existing RG.
  # proivde a name to use an existing resource group, specify the existing resource group name, 
  # set the argument to `create_resource_group = true` to create new resrouce group.
  resource_group_name = "rg-shared-westeurope-01"
  location            = "westeurope"

  # Dashboard configuration
  dashboards = [
    {
      name           = "my-cool-dashboard"
      json_file_path = "./test_dashboard.json"
      variables = {
        "title" = "example-dashboard"
      }
    }
  ]

  # Adding TAG's to your Azure resources 
  tags = {
    ProjectName  = "demo-internal"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}
```

## Terraform Usage

To run this example you need to execute following Terraform commands

```hcl
terraform init
terraform plan
terraform apply

```

Run `terraform destroy` when you don't need these resources.
