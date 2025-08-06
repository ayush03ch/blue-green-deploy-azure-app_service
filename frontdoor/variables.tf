variable "resource_group_name" {
  type        = string
  description = "Resource group for Front Door"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "East US"
}

variable "frontend_name" {
  type        = string
  description = "Front Door endpoint name"
}

variable "blue_backend_url" {
  type        = string
  description = "Blue environment backend hostname (App Service URL)"
}

variable "green_backend_url" {
  type        = string
  description = "Green environment backend hostname (App Service URL)"
}

variable "active_backend" {
  type        = string
  description = "Which backend is active: blue or green"
}
