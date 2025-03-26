variable "keycloak_url" {
  type    = string
  default = "http://localhost:8080"
}

variable "apple_client_id" {
  type      = string
  sensitive = true
}
variable "apple_client_secret" {
  type      = string
  sensitive = true
}

variable "realm_name" {
  type    = string
  default = "apple"
}

variable "standard_realm_name" {
  type    = string
  default = "standard"
}

variable "sub_to_username" {
  description = "If true, override 'sub' to have 'username' property value in the standard client"
  type        = bool
  default     = false
}

variable "authorization_url" {
  type    = string
  default = ""
}

variable "token_url" {
  type    = string
  default = ""
}

variable "user_info_url" {
  type    = string
  default = ""
}

variable "jwks_url" {
  type    = string
  default = ""
}
