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

output "spoke_vnet_name" {
  description = "The name of the spoke VNet"
  value       = azurerm_virtual_network.spoke_vnet.name
}

output "spoke_vnet_address_space" {
  description = "The address space of the spoke VNet"
  value       = azurerm_virtual_network.spoke_vnet.address_space
}

output "subnet_addresses" {
  description = "The address prefixes of all hub subnets"
  value = {
    management = azurerm_subnet.management.address_prefixes
    staff      = azurerm_subnet.staff.address_prefixes
    servers    = azurerm_subnet.servers.address_prefixes
  }
}

output "spoke_subnet_address" {
  description = "The address prefix of the spoke subnet"
  value       = azurerm_subnet.spoke_subnet.address_prefixes
}

output "nsg_name" {
  description = "The name of the Network Security Group"
  value       = azurerm_network_security_group.hub_nsg.name
}

output "route_table_names" {
  description = "The names of the route tables"
  value = {
    staff   = azurerm_route_table.staff_rt.name
    servers = azurerm_route_table.servers_rt.name
  }
}