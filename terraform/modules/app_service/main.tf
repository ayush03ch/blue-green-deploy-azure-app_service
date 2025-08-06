resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "asp" {
  name                = "${var.app_name}-${var.env}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"              # REQUIRED
  sku_name            = "B1"                 # REQUIRED
}

resource "azurerm_linux_web_app" "app" {
  name                = "${var.app_name}-${var.env}-web"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      docker_image_name   = var.docker_image     # e.g., "nginx"
    }
  }

  app_settings = {
    WEBSITES_PORT = "80"
    ENV_NAME      = var.env
  }
}
