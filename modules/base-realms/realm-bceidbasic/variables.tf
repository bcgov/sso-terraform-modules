variable "keycloak_url" {
  type    = string
  default = "http://localhost:8080"
}

variable "realm_name" {
  type    = string
  default = "bceidbasic"
}

variable "standard_realm_name" {
  type    = string
  default = "standard"
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

variable "sandbox_keycloak_url" {
  type    = string
  default = ""
}
