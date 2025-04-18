module "apple_idp" {
  source            = "../../oidc-idp"
  realm_id          = module.realm.id
  alias             = "${var.apple_realm_name}"
  display_name      = "Apple"
  gui_order         = "9"
  authorization_url = "${var.keycloak_url}/auth/realms/${var.apple_realm_name}/protocol/openid-connect/auth"
  token_url         = "${var.keycloak_url}/auth/realms/${var.apple_realm_name}/protocol/openid-connect/token"
  user_info_url     = "${var.keycloak_url}/auth/realms/${var.apple_realm_name}/protocol/openid-connect/userinfo"
  jwks_url          = "${var.keycloak_url}/auth/realms/${var.apple_realm_name}/protocol/openid-connect/certs"
  logout_url        = "${var.keycloak_url}/auth/realms/${var.apple_realm_name}/protocol/openid-connect/logout"
  client_id         = var.apple_client_id
  client_secret     = var.apple_client_secret
  social            = true

  post_broker_login_flow_alias = keycloak_authentication_flow.idp_post_login.alias
}

module "apple_idp_mappers" {
  source    = "../../idp-attribute-mappers"
  realm_id  = module.realm.id
  idp_alias = module.apple_idp.alias

  attributes = local.apple_attributes
}

resource "keycloak_custom_identity_provider_mapper" "apple_username" {
  realm                    = module.realm.id
  name                     = "username"
  identity_provider_alias  = module.apple_idp.alias
  identity_provider_mapper = "oidc-username-idp-mapper"

  extra_config = {
    syncMode = "INHERIT"
    template = "$${CLAIM.preferred_username}@$${ALIAS}"
  }
}