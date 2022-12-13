variable "client_id" {
  description = "The client or client identifier registered within the identity provider."
}

variable "client_secret" {
  description = "The client or client secret registered within the identity provider. This field is able to obtain its value from vault, use $${vault.ID} format."
}

# see https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/oidc_identity_provider
variable "realm_id" {
  description = "The ID of the Keycloak realm."
}

variable "realm_name" {
  description = "The name of the Keycloak realm."
}

variable "tenant_id" {
  type      = string
  sensitive = true
}