output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.this.name
}

output "primary_connection_string" {
  description = "Primary connection string"
  value       = azurerm_storage_account.this.primary_connection_string
  sensitive   = true
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "primary_web_endpoint" {
  description = "Primary web endpoint (static website)"
  value       = azurerm_storage_account.this.primary_web_endpoint
}

output "container_ids" {
  description = "Map of container names to IDs"
  value       = { for k, v in azurerm_storage_container.this : k => v.id }
}

