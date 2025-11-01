variable "storage_account_name" {
  description = "Name of the storage account (must be globally unique)"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "Storage replication type"
  type        = string
  default     = "LRS"
}

variable "enable_static_website" {
  description = "Enable static website hosting"
  type        = bool
  default     = false
}

variable "static_website_index_document" {
  description = "Index document for static website"
  type        = string
  default     = "index.html"
}

variable "static_website_error_document" {
  description = "Error document for static website"
  type        = string
  default     = "404.html"
}

variable "containers" {
  description = "Map of containers to create"
  type = map(object({
    access_type = string
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

