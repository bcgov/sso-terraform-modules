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

variable "google_client_id" {
  type      = string
  sensitive = true
  default   = ""
}

variable "google_client_secret" {
  type      = string
  sensitive = true
  default   = ""
}

variable "microsoft_tenant_id" {
  type      = string
  sensitive = true
  default   = ""
}
variable "microsoft_client_id" {
  type      = string
  sensitive = true
  default   = ""
}

variable "microsoft_client_secret" {
  type      = string
  sensitive = true
  default   = ""
}

variable "digitalcredential_client_id" {
  type      = string
  sensitive = true
  default   = ""
}

variable "digitalcredential_client_secret" {
  type      = string
  sensitive = true
  default   = ""
}

variable "username" {
  type      = string
  sensitive = true
  default   = ""
}

variable "password" {
  type      = string
  sensitive = true
  default   = ""
}

variable "digitalcredential_authorization_url" {
  type    = string
  default = ""
}

variable "digitalcredential_token_url" {
  type    = string
  default = ""
}
