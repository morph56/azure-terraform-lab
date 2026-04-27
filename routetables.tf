# Route Table for Staff Subnet
resource "azurerm_route_table" "staff_rt" {
  name                = "${var.business_name}-staff-rt"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  route {
    name           = "route-to-servers"
    address_prefix = "10.0.3.0/24"
    next_hop_type  = "VnetLocal"
  }

  route {
    name           = "route-to-spoke"
    address_prefix = "10.1.0.0/16"
    next_hop_type  = "VnetLocal"
  }
}

# Route Table for Servers Subnet
resource "azurerm_route_table" "servers_rt" {
  name                = "${var.business_name}-servers-rt"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  route {
    name           = "route-to-staff"
    address_prefix = "10.0.2.0/24"
    next_hop_type  = "VnetLocal"
  }

  route {
    name           = "route-to-spoke"
    address_prefix = "10.1.0.0/16"
    next_hop_type  = "VnetLocal"
  }
}

# Attach Route Table to Staff Subnet
resource "azurerm_subnet_route_table_association" "staff_rta" {
  subnet_id      = azurerm_subnet.staff.id
  route_table_id = azurerm_route_table.staff_rt.id
}

# Attach Route Table to Servers Subnet
resource "azurerm_subnet_route_table_association" "servers_rta" {
  subnet_id      = azurerm_subnet.servers.id
  route_table_id = azurerm_route_table.servers_rt.id
}