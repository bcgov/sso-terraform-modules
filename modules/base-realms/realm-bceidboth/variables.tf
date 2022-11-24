variable "keycloak_url" {
  default = "http://localhost:8080"
}

variable "realm_name" {
  default = "bceidboth"
}

variable "standard_realm_name" {
  default = "standard"
}

variable "saml_entity_id" {
  type      = string
  sensitive = true
}
variable "single_sign_on_service_url" {}

variable "signing_certificate" {
  type      = string
  sensitive = true
}

variable "sub_to_username" {
  description = "If true, override 'sub' to have 'username' property value in the standard client"
  type        = bool
  default     = false
}
