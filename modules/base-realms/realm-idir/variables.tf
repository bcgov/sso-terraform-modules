variable "keycloak_url" {
  default = "http://localhost:8080"
}

variable "realm_name" {
  default = "idir"
}

variable "standard_realm_name" {
  default = "standard"
}

variable "saml_entity_id" {}
variable "single_sign_on_service_url" {}

variable "signing_certificate" {
  type      = string
  sensitive = true
}
