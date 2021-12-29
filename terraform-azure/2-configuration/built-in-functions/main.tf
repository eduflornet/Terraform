
terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.90.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "app_name" {
  description = "Name of application"
}

variable "environment" {
  description = "Environment Name"
}

# To capitalize everything inside, we encapsulate the format function in the upper function, which capitalizes all its contents
resource "azurerm_resource_group" "rg-app" {
  name = upper(format("RG-%s-%s", var.app_name,
  var.environment))
  location = "westeurope"
}
