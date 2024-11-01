variable "virtual_hubs" {
  type = object({
    name                     = string
    location                 = string
    address_prefix           = string
    extended_vnet            = bool
    firewall_sku_tier        = string
    firewall_public_ip_count = number
    deploy_extended_vnet     = bool
  })
}

variable "virtual_wan_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}