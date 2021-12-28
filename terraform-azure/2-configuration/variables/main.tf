terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.90.0"
    }
  }
}

provider "azurerm"{
  features {}
}


variable "resource_group_name" {
  description ="The name of the resource group"
}

variable "location" {
  description ="The name of the Azure location"
  default ="West Europe"
  validation {  # TF 0.13
    condition     = can(index(["westeurope","westus"], var.location) >= 0)
    error_message = "The location must be westeurope or westus."
  }
}


resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
}