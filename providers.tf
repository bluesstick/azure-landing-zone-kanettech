terraform {
    required_version = ">= 1.5.0"

    backend "azurerm" {
        resource_group_name  = "rg-tfstate"
        storage_account_name = "stttfstateedwin2026"
        container_name       = "tfstate"
        key                  = "landing-zone.tfstate"
    }

    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.0"
        }
    }
}

provider "azurerm" {
    features {}
}
