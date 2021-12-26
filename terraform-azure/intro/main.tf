  terraform {
    required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.90.0"
    }
  }
}

provider "azurerm" {
  alias = "prueba"
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
}

resource "azurerm_resource_group" "axample" {
  name = "example-resource-group"
  location = "West Europe"
}


