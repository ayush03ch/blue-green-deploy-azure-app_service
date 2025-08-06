resource "azurerm_resource_group" "fd_rg" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_cdn_frontdoor_profile" "fd_profile" {
  name                = var.frontend_name
  resource_group_name = azurerm_resource_group.fd_rg.name
  sku_name            = "Standard_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "fd_endpoint" {
  name                     = "${var.frontend_name}-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id
}

resource "azurerm_cdn_frontdoor_origin_group" "origin_group" {
  name                     = "${var.frontend_name}-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id

  health_probe {
    path                = "/"
    protocol            = "Http"
    request_type        = "GET"
    interval_in_seconds = 30
  }

  load_balancing {
    sample_size                = 4
    successful_samples_required = 3
  }
}

resource "azurerm_cdn_frontdoor_origin" "blue" {
  name                          = "blue-origin"
  host_name                     = var.blue_backend_url
  origin_host_header            = var.blue_backend_url
  certificate_name_check_enabled = false
  http_port                     = 80
  https_port                    = 443
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.origin_group.id
}

resource "azurerm_cdn_frontdoor_origin" "green" {
  name                          = "green-origin"
  host_name                     = var.green_backend_url
  origin_host_header            = var.green_backend_url
  certificate_name_check_enabled = false
  http_port                     = 80
  https_port                    = 443
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.origin_group.id
}

resource "azurerm_cdn_frontdoor_route" "fd_route" {
  name                          = "${var.frontend_name}-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.fd_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.origin_group.id
  cdn_frontdoor_origin_ids      = var.active_backend == "blue" ? [azurerm_cdn_frontdoor_origin.blue.id] : [azurerm_cdn_frontdoor_origin.green.id]
  supported_protocols           = ["Http", "Https"]
  patterns_to_match             = ["/*"]
  forwarding_protocol           = "MatchRequest"
  enabled                       = true
}
