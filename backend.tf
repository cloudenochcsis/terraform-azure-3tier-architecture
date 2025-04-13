terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"  # Resource group for storage account
    storage_account_name = "tfstate12345"        # Storage account name (must be globally unique)
    container_name      = "tfstate"              # Container name
    key                 = "3tier.terraform.tfstate"  # State file name
  }
} 