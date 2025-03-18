
resource "keycloak_realm" "realm" {
  realm   = "my-realm"
  enabled = true
}

resource "keycloak_oidc_google_identity_provider" "google" {
  realm       = module.realm.id
  client_id     = var.client_id
  client_secret = var.client_secret

  sync_mode   = "FORCE"

  # Defaults to empty, no OTP checking
  # post_broker_login_flow_alias  = ""


  # realm         = keycloak_realm.realm.id
  # client_id     = var.google_identity_provider_client_id
  # client_secret = var.google_identity_provider_client_secret
  trust_email   = true
  
  # These may need to be updated
  # default_scopes = "openid profile email"

  extra_config = {
    "jsonField"     = "email"
    "userAttribute" = "email"
  }
}





