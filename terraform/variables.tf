variable "app_name" {
  description = "Base name of the application"
  type        = string
}

variable "env" {
  description = "Deployment environment (blue or green)"
  type        = string
}

variable "resource_group_name" {
  description = "Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "East US"
}

variable "docker_image" {
  description = "Docker image to deploy"
  type        = string
}