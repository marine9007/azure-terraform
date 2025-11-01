variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-free-tier"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
  }
}

# Storage Account variables
variable "storage_account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"
}

# App Service variables
variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
  default     = ""
}

variable "enable_static_web_app" {
  description = "Enable Static Web App deployment"
  type        = bool
  default     = true
}

# Note: AKS is NOT free - control plane is free but nodes cost money
# Uncomment and use only if you have Azure credits
# variable "enable_aks" {
#   description = "Enable AKS cluster (WARNING: NOT FREE - nodes cost money)"
#   type        = bool
#   default     = false
# }

# variable "aks_node_count" {
#   description = "Number of nodes in AKS cluster"
#   type        = number
#   default     = 1
# }

# variable "aks_node_vm_size" {
#   description = "VM size for AKS nodes (smallest: Standard_B2s)"
#   type        = string
#   default     = "Standard_B2s"
# }

