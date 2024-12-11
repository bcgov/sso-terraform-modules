

resource "keycloak_oidc_identity_provider" "bcsc_identity_provider" {
  realm              = var.standard_realm_id
  alias              = var.bcsc_resource_name
  enabled            = true
  authorization_url  = "https://idsit.gov.bc.ca/login/oidc/authorize"
  client_id          = var.bcsc_client_id
  client_secret      = var.bcsc_client_secret
  token_url          = "https://idsit.gov.bc.ca/oauth2/token"
  store_token        = true
  display_name       = "BC Services Card"
  validate_signature = true
  jwks_url           = "https://idsit.gov.bc.ca/oauth2/jwk"
  default_scopes     = "openid profile address email"
  user_info_url      = "https://idsit.gov.bc.ca/oauth2/userinfo"

  extra_config = {
    "clientAuthMethod" = "client_secret_post"
  }
}

resource "keycloak_user_template_importer_identity_provider_mapper" "bcsc_idp_username_importer" {
  realm                   = var.standard_realm_id
  name                    = "username"
  identity_provider_alias = keycloak_oidc_identity_provider.bcsc_identity_provider.alias
  template                = "$${CLAIM.sub}@$${ALIAS}"

  # extra_config with syncMode is required in Keycloak 10+
  extra_config = {
    syncMode = "FORCE"
  }
}

resource "keycloak_openid_client_scope" "bcsc_client_scope" {
  realm_id               = var.standard_realm_id
  name                   = var.bcsc_resource_name
  description            = "When requested, this scope will map a user's group memberships to a claim"
  include_in_token_scope = true
  gui_order              = 1
  consent_screen_text    = true
}

resource "keycloak_generic_protocol_mapper" "bcsc_client_scope_attributes_mapper" {
  realm_id        = var.standard_realm_id
  name            = "attributes"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-idp-userinfo-mapper"
  client_scope_id = keycloak_openid_client_scope.bcsc_client_scope.id
  config = {
    "introspection.token.claim" : "true",
    "userAttributes" : "address,locality,display_name,given_names,family_name,street_address,email,country,postal_code,region,given_name",
    "userinfo.token.claim" : "true",
    "id.token.claim" : "true",
    "lightweight.claim" : "false",
    "access.token.claim" : "true",
    "encryptionExpected" : "false",
    "signatureExpected" : "true"
  }
}
