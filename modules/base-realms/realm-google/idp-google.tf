resource "keycloak_oidc_google_identity_provider" "google" {
  realm       = module.realm.id
  client_id     = var.client_id
  client_secret = var.client_secret

  sync_mode   = "FORCE"

  trust_email   = false
  disable_user_info = true

  # These may need to be updated
  default_scopes = "openid"

}





