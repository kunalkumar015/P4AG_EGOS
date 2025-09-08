terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  use_msi  = false
}

provider "azurerm" {
  features {}
  alias           = "uat" 
  subscription_id = "230c211e-8a74-478c-9999-e92284ae6e59" # UAT
  use_msi = false
}
