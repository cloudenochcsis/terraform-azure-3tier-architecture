# Network Security Group for DB Tier
resource "azurerm_network_security_group" "db" {
  name                = "db-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "AllowAppTier"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# MySQL Flexible Server
resource "azurerm_mysql_flexible_server" "main" {
  name                = "mysql-${var.db_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  administrator_login    = var.db_admin
  administrator_password = var.db_password

  sku_name = "B_Standard_B1ms"
  version  = "8.0.21"

  storage {
    size_gb = 20
  }

  backup_retention_days = 7

  high_availability {
    mode = "ZoneRedundant"
  }

  maintenance_window {
    day_of_week  = 0
    start_hour   = 8
    start_minute = 0
  }
}

# Private Endpoint for MySQL
resource "azurerm_private_endpoint" "mysql" {
  name                = "mysql-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_db_subnet_ids[0]
  tags                = var.tags

  private_service_connection {
    name                           = "mysql-private-connection"
    private_connection_resource_id = azurerm_mysql_flexible_server.main.id
    is_manual_connection           = false
    subresource_names              = ["mysqlServer"]
  }
}
