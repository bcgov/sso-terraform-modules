module "microsoft_idp" {
  source                = "../../oidc-idp"
  realm_id              = module.realm.id
  alias                 = var.microsoft_realm_name
  display_name          = "Microsoft"
  gui_order             = "9"
  authorization_url     = "${var.keycloak_url}/auth/realms/${var.microsoft_realm_name}/protocol/openid-connect/auth"
  token_url             = "${var.keycloak_url}/auth/realms/${var.microsoft_realm_name}/protocol/openid-connect/token"
  user_info_url         = "${var.keycloak_url}/auth/realms/${var.microsoft_realm_name}/protocol/openid-connect/userinfo"
  jwks_url              = "${var.keycloak_url}/auth/realms/${var.microsoft_realm_name}/protocol/openid-connect/certs"
  logout_url            = "${var.keycloak_url}/auth/realms/${var.microsoft_realm_name}/protocol/openid-connect/logout"
  client_id             = var.microsoft_client_id
  client_secret         = var.microsoft_client_secret
  tooltip               = "Microsoft social account"
  backchannel_supported = false
  social                = true

  post_broker_login_flow_alias = keycloak_authentication_flow.idp_post_login.alias
}

module "microsoft_idp_mappers" {
  source    = "../../idp-attribute-mappers"
  realm_id  = module.realm.id
  idp_alias = module.microsoft_idp.alias

  attributes = local.microsoft_attributes
}

resource "keycloak_custom_identity_provider_mapper" "microsoft_username" {
  realm                    = module.realm.id
  name                     = "username"
  identity_provider_alias  = module.microsoft_idp.alias
  identity_provider_mapper = "oidc-username-idp-mapper"

  extra_config = {
    syncMode = "INHERIT"
    template = "$${CLAIM.preferred_username}@$${ALIAS}"
  }
}
