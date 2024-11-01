variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "virtual_wan" {
  type = object({
    name     = string
    location = string
  })
}

variable "virtual_hubs" {
  type = map(object({
    name                     = string
    location                 = string
    address_prefix           = string
    extended_vnet            = bool
    firewall_sku_tier        = string
    firewall_public_ip_count = number
    deploy_extended_vnet     = bool
  }))
}
