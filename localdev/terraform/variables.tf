variable "client_id" {
  description = "The client_id for the Keycloak client in Master Realm"
  default     = "terraform-cli"
}

variable "client_secret" {
  description = "The client_secret for the Keycloak client"
  default     = ""
}

variable "idir_client_id" {
  description = "The client_id for the Keycloak client in Master Realm"
  default     = ""
}

variable "idir_client_secret" {
  description = "The client_secret for the Keycloak client"
  default     = ""
}

variable "bceidbasic_client_id" {
  description = "The client_id for the Keycloak client in Master Realm"
  default     = ""
}

variable "bceidbasic_client_secret" {
  description = "The client_secret for the Keycloak client"
  default     = ""
}

variable "bceidbusiness_client_id" {
  description = "The client_id for the Keycloak client in Master Realm"
  default     = ""
}

variable "bceidbusiness_client_secret" {
  description = "The client_secret for the Keycloak client"
  default     = ""
}

variable "bceidboth_client_id" {
  description = "The client_id for the Keycloak client in Master Realm"
  default     = ""
}

variable "bceidboth_client_secret" {
  description = "The client_secret for the Keycloak client"
  default     = ""
}

variable "username" {
  description = "The username of the user used by the provider for authentication via the password grant"
  default     = "admin"
}

variable "password" {
  description = "The password of the user used by the provider for authentication via the password grant"
  default     = "admin"
}

variable "keycloak_url" {
  description = "The URL of the Keycloak instance"
  default     = "http://localhost:8080"
}

variable "github_client_id" {
  type      = string
  sensitive = true
}

variable "github_client_secret" {
  type      = string
  sensitive = true
}

variable "siteminder_signing_certificate" {
  type      = string
  sensitive = true
}

variable "azureidir_client_id" {
  type      = string
  sensitive = true
}

variable "azureidir_client_secret" {
  type      = string
  sensitive = true
}
