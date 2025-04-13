terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Call modules
module "networking" {
  source = "./modules/networking"

  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  vnet_cidr                = var.vnet_cidr
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
  tags                     = var.tags
}

module "web" {
  source = "./modules/web"

  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  public_subnet_ids   = module.networking.public_subnet_ids
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  ssh_key             = var.ssh_key
  tags                = var.tags
}

module "app" {
  source = "./modules/app"

  resource_group_name    = azurerm_resource_group.main.name
  location               = var.location
  private_app_subnet_ids = module.networking.private_app_subnet_ids
  vm_size                = var.vm_size
  admin_username         = var.admin_username
  ssh_key                = var.ssh_key
  tags                   = var.tags
}

module "db" {
  source = "./modules/db"

  resource_group_name   = azurerm_resource_group.main.name
  location              = var.location
  private_db_subnet_ids = module.networking.private_db_subnet_ids
  db_name               = var.db_name
  db_admin              = var.db_admin
  db_password           = var.db_password
  tags                  = var.tags
}
