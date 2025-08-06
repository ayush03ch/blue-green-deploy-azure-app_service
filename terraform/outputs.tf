output "app_service_url" {
  value = module.app_service.app_url
  description = "URL of the deployed App Service"
}