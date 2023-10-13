variable "keycloak_url" {
  description = "The URL of the Keycloak instance"
  default     = "http://localhost:8080"
}

variable "siteminder_signing_certificate" {
  type      = string
  sensitive = true
  default   = ""
}

variable "azureidir_tenant_id" {
  type      = string
  sensitive = true
  default   = ""
}

variable "azureidir_client_id" {
  type      = string
  sensitive = true
  default   = ""
}

variable "azureidir_client_secret" {
  type      = string
  sensitive = true
  default   = ""
}

variable "github_client_id" {
  type      = string
  sensitive = true
  default   = ""
}

variable "github_client_secret" {
  type      = string
  sensitive = true
  default   = ""
}

variable "verifiablecredential_client_id" {
  type      = string
  sensitive = true
  default   = ""
}

variable "verifiablecredential_client_secret" {
  type      = string
  sensitive = true
  default   = ""
}
