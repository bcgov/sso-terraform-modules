variable "keycloak_url" {
  default = "http://localhost:8080"
}

variable "client_id" {
  type      = string
  sensitive = true
}
variable "client_secret" {
  type      = string
  sensitive = true
}

variable "realm_name" {
  default = "github"
}

variable "standard_realm_name" {
  default = "standard"
}

variable "github_org" {
  description = "The allowed github org name"
  default     = "bcgov bcgov-c BCDevOps"
}

variable "sub_to_username" {
  description = "If true, override 'sub' to have 'username' property value in the standard client"
  type        = bool
  default     = false
}
