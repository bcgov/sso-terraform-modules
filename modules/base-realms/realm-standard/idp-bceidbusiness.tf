module "bceidbusiness_idp" {
  source            = "../../oidc-idp"
  realm_id          = module.realm.id
  alias             = var.bceidbusiness_realm_name
  display_name      = "BCeID Business"
  authorization_url = "${var.keycloak_url}/auth/realms/${var.bceidbusiness_realm_name}/protocol/openid-connect/auth"
  token_url         = "${var.keycloak_url}/auth/realms/${var.bceidbusiness_realm_name}/protocol/openid-connect/token"
  user_info_url     = "${var.keycloak_url}/auth/realms/${var.bceidbusiness_realm_name}/protocol/openid-connect/userinfo"
  jwks_url          = "${var.keycloak_url}/auth/realms/${var.bceidbusiness_realm_name}/protocol/openid-connect/certs"
  logout_url        = "${var.keycloak_url}/auth/realms/${var.bceidbusiness_realm_name}/protocol/openid-connect/logout"
  client_id         = var.bceidbusiness_client_id
  client_secret     = var.bceidbusiness_client_secret
}

module "bceidbusiness_idp_mappers" {
  source    = "../../idp-attribute-mappers"
  realm_id  = module.realm.id
  idp_alias = module.bceidbusiness_idp.alias

  attributes = local.bceidbusiness_attributes
}

resource "keycloak_custom_identity_provider_mapper" "bceidbusiness_username" {
  realm                    = module.realm.id
  name                     = "username"
  identity_provider_alias  = module.bceidbusiness_idp.alias
  identity_provider_mapper = "oidc-username-idp-mapper"

  extra_config = {
    syncMode = "INHERIT"
    template = "$${CLAIM.preferred_username}@$${ALIAS}"
  }
}
