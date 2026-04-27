# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.business_name}-rg"
  location = var.location
}

# Hub Virtual Network
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "${var.business_name}-hub-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Management Subnet
resource "azurerm_subnet" "management" {
  name                 = "subnet-management"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Staff Subnet
resource "azurerm_subnet" "staff" {
  name                 = "subnet-staff"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Servers Subnet
resource "azurerm_subnet" "servers" {
  name                 = "subnet-servers"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Network Security Group
resource "azurerm_network_security_group" "hub_nsg" {
  name                = "${var.business_name}-hub-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Rule 1 - Allow internal traffic between subnets
  security_rule {
    name                       = "allow-internal"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.0.0/16"
    destination_address_prefix = "10.0.0.0/16"
  }

  # Rule 2 - Block all other inbound traffic
  security_rule {
    name                       = "deny-all-inbound"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Attach NSG to Staff Subnet
resource "azurerm_subnet_network_security_group_association" "staff_nsg" {
  subnet_id                 = azurerm_subnet.staff.id
  network_security_group_id = azurerm_network_security_group.hub_nsg.id
}

# Attach NSG to Servers Subnet
resource "azurerm_subnet_network_security_group_association" "servers_nsg" {
  subnet_id                 = azurerm_subnet.servers.id
  network_security_group_id = azurerm_network_security_group.hub_nsg.id
}