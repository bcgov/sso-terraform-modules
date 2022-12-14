variable "keycloak_url" {
  default = "http://localhost:8080"
  type    = string
}

variable "realm_name" {
  default = "bceidbusiness"
  type    = string
}

variable "standard_realm_name" {
  default = "standard"
  type    = string
}

variable "saml_entity_id" {
  type      = string
  sensitive = true
}
variable "single_sign_on_service_url" {
  type = string
}

variable "signing_certificate" {
  type      = string
  sensitive = true
}

variable "sub_to_username" {
  description = "If true, override 'sub' to have 'username' property value in the standard client"
  type        = bool
  default     = false
}
