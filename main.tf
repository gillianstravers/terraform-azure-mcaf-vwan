resource "azurerm_resource_group" "this" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

resource "azurerm_virtual_wan" "this" {
  name                = var.virtual_wan.name
  resource_group_name = azurerm_resource_group.this.name
  location            = coalesce(var.virtual_wan.location, azurerm_resource_group.this.location)
}

module "vhub" {
  source         = "./modules/vhub"
  virtual_hubs   = var.virtual_hubs
  virtual_wan_id = azurerm_virtual_wan.this.id
}