terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      #version = "~> 3.13.0"
      version = "~> 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  use_msi  = false
#  alias = "wwe"
  
}
