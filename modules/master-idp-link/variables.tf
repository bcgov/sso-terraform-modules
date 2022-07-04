variable "idp_realm_id" {}
variable "idp_realm_name" {}
variable "idp_public_attrs" {}
variable "otp_required" {
  default = false
}
variable "keycloak_url" {
  description = "The URL of the Keycloak instance"
  default     = "http://localhost:8080"
}
