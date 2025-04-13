# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.resource_group_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [var.vnet_cidr]
  tags                = var.tags
}

# Public Subnets
resource "azurerm_subnet" "public" {
  count                = length(var.public_subnet_cidrs)
  name                 = "public-subnet-${count.index + 1}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.public_subnet_cidrs[count.index]]
}

# Private App Subnets
resource "azurerm_subnet" "private_app" {
  count                = length(var.private_app_subnet_cidrs)
  name                 = "private-app-subnet-${count.index + 1}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.private_app_subnet_cidrs[count.index]]
}

# Private DB Subnets
resource "azurerm_subnet" "private_db" {
  count                = length(var.private_db_subnet_cidrs)
  name                 = "private-db-subnet-${count.index + 1}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.private_db_subnet_cidrs[count.index]]
}

# NAT Gateway
resource "azurerm_public_ip" "nat" {
  name                = "nat-gateway-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway" "main" {
  name                    = "nat-gateway"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  tags                    = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "main" {
  nat_gateway_id       = azurerm_nat_gateway.main.id
  public_ip_address_id = azurerm_public_ip.nat.id
}

# Route Tables
resource "azurerm_route_table" "private" {
  name                          = "private-route-table"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = false
  tags                          = var.tags

  route {
    name                   = "nat-gateway"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_nat_gateway.main.id
  }
}

# Associate Route Tables with Private Subnets
resource "azurerm_subnet_route_table_association" "private_app" {
  count          = length(var.private_app_subnet_cidrs)
  subnet_id      = azurerm_subnet.private_app[count.index].id
  route_table_id = azurerm_route_table.private.id
}

resource "azurerm_subnet_route_table_association" "private_db" {
  count          = length(var.private_db_subnet_cidrs)
  subnet_id      = azurerm_subnet.private_db[count.index].id
  route_table_id = azurerm_route_table.private.id
}

# Bastion Host
resource "azurerm_public_ip" "bastion" {
  name                = "bastion-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_bastion_host" "main" {
  name                = "bastion-host"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.public[0].id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}
