variable "keycloak_url" {
  default = "http://localhost:8080"
}

variable "azure_tenant_id" {
  type      = string
  sensitive = true
}
variable "azure_client_id" {
  type      = string
  sensitive = true
}
variable "azure_client_secret" {
  type      = string
  sensitive = true
}

variable "realm_name" {
  default = "azureidir"
}

variable "standard_realm_name" {
  default = "standard"
}

variable "sub_to_username" {
  description = "If true, override 'sub' to have 'username' property value in the standard client"
  type        = bool
  default     = false
}
