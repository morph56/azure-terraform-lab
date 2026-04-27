output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "hub_vnet_name" {
  description = "The name of the hub VNet"
  value       = azurerm_virtual_network.hub_vnet.name
}

output "hub_vnet_address_space" {
  description = "The address space of the hub VNet"
  value       = azurerm_virtual_network.hub_vnet.address_space
}

output "subnet_addresses" {
  description = "The address prefixes of all subnets"
  value = {
    management = azurerm_subnet.management.address_prefixes
    staff      = azurerm_subnet.staff.address_prefixes
    servers    = azurerm_subnet.servers.address_prefixes
  }
}

output "nsg_name" {
  description = "The name of the Network Security Group"
  value       = azurerm_network_security_group.hub_nsg.name
}