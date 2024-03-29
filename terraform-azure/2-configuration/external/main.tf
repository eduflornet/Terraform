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

variable "application_name" {
  description = "The name of application"
}

variable "environment_name" {
  description = "The name of environment"
}

variable "country_code" {
  description = "The country code (FR-US-...)"
}

locals {
  resource_name = "${var.application_name}-${var.environment_name}-${var.country_code}"
}

resource "azurerm_resource_group" "rg" {
  name     = "RG-${local.resource_name}"
  location = data.external.getlocation.result.location
}


data "external" "getlocation" {
  program = ["Powershell.exe", "./GetLocation.ps1"]

  query = {
    environment = "${var.environment_name}"
  }
}

output "locationname" {
  value = data.external.getlocation.result.location
}
