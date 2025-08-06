provider "azurerm" {
  features {}
  subscription_id = "5215b5b9-541f-416d-9960-7c5a91c252d1"
}

module "app_service" {
  source              = "./modules/app_service"
  app_name            = var.app_name
  env                 = var.env
  resource_group_name = var.resource_group_name
  location            = var.location
  docker_image        = var.docker_image
}