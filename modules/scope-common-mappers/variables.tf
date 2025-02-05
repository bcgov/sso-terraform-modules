variable "realm_id" {}

variable "scope_name" {}

variable "add_nonce" {
  description = "if true nonce mapper is added to common scope"
  type        = bool
  default     = false
}

variable "add_session_state" {
  description = "if true session_state mapper is added to common scope"
  type        = bool
  default     = false
}
