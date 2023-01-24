variable "realm_id" {}
variable "scope_name" {}
variable "enable_full_name_mapper" {
  description = "If true, add name claim to all the tokens"
  type        = string
  default     = "true"
}
