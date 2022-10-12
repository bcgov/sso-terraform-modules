variable "idp_realm_id" {}
variable "idp_realm_name" {}
variable "idp_display_name" {
  description = "The display name of the identity provider"
  default     = ""
}
variable "idp_public_attrs" {}
variable "otp_required" {
  default = false
}
variable "keycloak_url" {
  description = "The URL of the Keycloak instance"
  default     = "http://localhost:8080"
}
