
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


#Using Conditional (ternary) operator with upper and format functions
resource "azurerm_resource_group" "rg-app" {
  name     = var.environment == "Production" ? upper(format("RG-%s", var.app_name)) : upper(format("RG-%s-%s", var.app_name, var.environment))
  location = "westeurope"
}
