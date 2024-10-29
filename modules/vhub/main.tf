
resource "azurerm_virtual_hub" "this" {
  for_each            = var.virtual_hubs
  name                = each.value.name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  address_prefix      = each.value.address_prefix
  virtual_wan_id =  var.virtual_wan_id
}

resource "azurerm_virtual_hub_routing_intent" "this" {
  for_each       = var.virtual_hubs
  name           = "${each.value.name}-routing-intent"
  virtual_hub_id = azurerm_virtual_hub.this[each.key].id

  routing_policy {
    name         = "_policy_PublicTraffic"
    destinations = ["Internet"]
    next_hop     = azurerm_firewall.this[each.key].id
  }
  routing_policy {
    name         = "_policy_PrivateTraffic"
    destinations = ["PrivateTraffic"]
    next_hop     = azurerm_firewall.this[each.key].id
  }
}

resource "azurerm_firewall" "this" {
  for_each            = var.virtual_hubs
  name                = "${each.value.name}-firewall"
  resource_group_name = each.value.rg_name
  location            = each.value.location
  sku_name            = "AZFW_Hub"
  sku_tier            = each.value.firewall_sku_tier
  virtual_hub {
    virtual_hub_id  = azurerm_virtual_hub.this[each.key].id
    public_ip_count = each.value.firewall_public_ip_count
  }
}

resource "azurerm_firewall_policy" "this" {
  for_each            = var.virtual_hubs
  name                = "${each.value.name}-firewall-policy"
  resource_group_name = each.value.rg_name
  location            = each.value.location
  sku                 = each.value.firewall_sku_tier
}