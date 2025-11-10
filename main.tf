# Random suffix for globally unique names
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

# Storage Account (Free tier: 5GB blob storage, 5GB file storage)
resource "azurerm_storage_account" "main" {
  name                     = "st${local.suffix}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication

  # Enable static website hosting (free)
  static_website {
    index_document = "index.html"
  }

  tags = local.common_tags
}

# Storage Container (free)
resource "azurerm_storage_container" "main" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

# App Service Plan (F1 Free tier: 1GB disk, 1GB RAM, 60 min/day compute)
resource "azurerm_service_plan" "main" {
  name                = "plan-${var.environment}-${local.suffix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "F1" # Free tier

  tags = local.common_tags
}

# App Service (Free tier)
resource "azurerm_linux_web_app" "main" {
  name                = coalesce(var.app_service_name, "app-${var.environment}-${local.suffix}")
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_service_plan.main.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    always_on = false # Must be false for Free tier

    application_stack {
      node_version = "18-lts"
    }
  }

  tags = local.common_tags
}

# Static Web App (Free tier: 100GB bandwidth/month, custom domain, SSL)
resource "azurerm_static_web_app" "main" {
  count               = var.enable_static_web_app ? 1 : 0
  name                = "stapp-${var.environment}-${local.suffix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = "eastus2" # Static Web Apps have limited regions
  sku_tier            = "Free"
  sku_size            = "Free"

  tags = local.common_tags
}

# -----------------------------------------------------------------------------
# AKS Example (COMMENTED OUT - NOT FREE)
# -----------------------------------------------------------------------------
# Note: AKS control plane is free, but worker nodes are NOT free
# Even the smallest VM (Standard_B2s) costs ~$30/month
# Only uncomment if you have Azure credits or free trial
#
# resource "azurerm_kubernetes_cluster" "main" {
#   count               = var.enable_aks ? 1 : 0
#   name                = "aks-${var.environment}-${local.suffix}"
#   location            = azurerm_resource_group.main.location
#   resource_group_name = azurerm_resource_group.main.name
#   dns_prefix          = "aks-${var.environment}-${local.suffix}"
#
#   default_node_pool {
#     name       = "default"
#     node_count = var.aks_node_count
#     vm_size    = var.aks_node_vm_size
#     
#     # Enable auto-scaling to scale to 0 when not in use (helps reduce costs)
#     enable_auto_scaling = true
#     min_count          = 0
#     max_count          = var.aks_node_count
#   }
#
#   identity {
#     type = "SystemAssigned"
#   }
#
#   tags = local.common_tags
# }

