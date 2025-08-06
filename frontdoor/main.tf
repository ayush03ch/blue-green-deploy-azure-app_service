provider "azurerm" {
  features {}
  subscription_id = "5215b5b9-541f-416d-9960-7c5a91c252d1"
}

module "frontdoor" {
  source              = "./modules/frontdoor"
  resource_group_name = var.resource_group_name
  location            = var.location
  frontend_name       = var.frontend_name
  blue_backend_url    = var.blue_backend_url
  green_backend_url   = var.green_backend_url
  active_backend      = var.active_backend
}
