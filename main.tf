#---------------------------------
# Local declarations
#---------------------------------
locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, azurerm_resource_group.rg.*.name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, azurerm_resource_group.rg.*.location, [""]), 0)
}

#---------------------------------------------------------
# Resource Group Creation or selection - Default is "true"
#----------------------------------------------------------
data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = lower(var.resource_group_name)
  location = var.location
  tags     = merge({ "ResourceName" = format("%s", var.resource_group_name) }, var.tags, )
}

#---------------------------------------------------------
# Dashboard Resouce creation - Default is "true"
#----------------------------------------------------------
resource "azurerm_portal_dashboard" "main" {
  for_each             = { for k in var.dashboards : k.name => k }
  name                 = format("%s", each.key)
  resource_group_name  = local.resource_group_name
  location             = local.location
  dashboard_properties = templatefile(each.value.json_file_path, each.value.variables)
  tags                 = merge({ "ResourceName" = format("%s", each.key) }, var.tags, )
}
