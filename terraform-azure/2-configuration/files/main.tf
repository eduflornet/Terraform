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

resource "local_file" "myfile" {
  content  = "This is my text"
  filename = "../mytextfile.txt"
}

