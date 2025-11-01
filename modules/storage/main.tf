resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
  
  dynamic "static_website" {
    for_each = var.enable_static_website ? [1] : []
    content {
      index_document     = var.static_website_index_document
      error_404_document = var.static_website_error_document
    }
  }

  tags = var.tags
}

resource "azurerm_storage_container" "this" {
  for_each              = var.containers
  name                  = each.key
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = each.value.access_type
}

