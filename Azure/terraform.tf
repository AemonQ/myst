provider "azurerm" {
    version = "=2.13.0"
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name = "terraform_state"
        storage_account_name = "tfblobstrg"
        container_name = "terraform.tfstate"
    }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "resourcegroup" {
    name = "terra-rg"
    location = "west us"
}

resource "azurerm_app_service_plan" "serviceplan" {
    name = "terra-sp"
    location = azurerm_resource_group.resourcegroup.location
    resource_group_name = azurerm_resource_group.resourcegroup.name

    sku {
        tier = "Standard"
        size = "S1"
    }
}

resource "azurerm_app_service" "appservice" {
    name = "terra-as"
    location = azurerm_resource_group.resourcegroup.location
    app_service_plan_id = azurerm_app_service_plan.serviceplan.id
}