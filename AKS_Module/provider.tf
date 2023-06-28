terraform {

  required_version = ">=1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "devops-terraform-rg"
    storage_account_name = "devopstfsask01"
    container_name       = "tf-container"
    key                  = "terraform_aks.tfstate"
  }

}

provider "azurerm" {
  features {}
}