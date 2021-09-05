# Azurerm Provider configuration
provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}

module "dashboard" {
  // source  = "kumarvna/dashboard/azurerm"
  // version = "1.0.0"
  source = "../../"

  # By default, this module will not create a resource group. Location will be same as existing RG.
  # proivde a name to use an existing resource group, specify the existing resource group name, 
  # set the argument to `create_resource_group = true` to create new resrouce group.
  resource_group_name = "rg-shared-westeurope-01"
  location            = "westeurope"

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
