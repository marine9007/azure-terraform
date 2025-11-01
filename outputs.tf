output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.main.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.main.name
}

output "storage_account_primary_connection_string" {
  description = "Primary connection string for the storage account"
  value       = azurerm_storage_account.main.primary_connection_string
  sensitive   = true
}

output "storage_static_website_url" {
  description = "URL of the static website hosted on storage account"
  value       = azurerm_storage_account.main.primary_web_endpoint
}

output "app_service_name" {
  description = "Name of the App Service"
  value       = azurerm_linux_web_app.main.name
}

output "app_service_default_hostname" {
  description = "Default hostname of the App Service"
  value       = azurerm_linux_web_app.main.default_hostname
}

output "app_service_url" {
  description = "URL of the App Service"
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "static_web_app_default_hostname" {
  description = "Default hostname of the Static Web App"
  value       = var.enable_static_web_app ? azurerm_static_web_app.main[0].default_host_name : null
}

output "static_web_app_api_key" {
  description = "API key for Static Web App deployment"
  value       = var.enable_static_web_app ? azurerm_static_web_app.main[0].api_key : null
  sensitive   = true
}

# AKS Outputs (uncomment if you enable AKS)
# output "aks_cluster_name" {
#   description = "Name of the AKS cluster"
#   value       = var.enable_aks ? azurerm_kubernetes_cluster.main[0].name : null
# }

# output "aks_cluster_endpoint" {
#   description = "Endpoint for the AKS cluster"
#   value       = var.enable_aks ? azurerm_kubernetes_cluster.main[0].kube_config[0].host : null
#   sensitive   = true
# }

# output "aks_cluster_kubeconfig" {
#   description = "Kubeconfig for the AKS cluster"
#   value       = var.enable_aks ? azurerm_kubernetes_cluster.main[0].kube_config_raw : null
#   sensitive   = true
# }

