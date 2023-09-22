module "verifiablecredential_idp" {
  source                = "../../oidc-idp"
  realm_id              = module.realm.id
  alias                 = var.verifiablecredential_realm_name
  display_name          = "Verifiable Credential"
  gui_order             = "8"
  authorization_url     = "${var.keycloak_url}/auth/realms/${var.verifiablecredential_realm_name}/protocol/openid-connect/auth"
  token_url             = "${var.keycloak_url}/auth/realms/${var.verifiablecredential_realm_name}/protocol/openid-connect/token"
  user_info_url         = "${var.keycloak_url}/auth/realms/${var.verifiablecredential_realm_name}/protocol/openid-connect/userinfo"
  jwks_url              = "${var.keycloak_url}/auth/realms/${var.verifiablecredential_realm_name}/protocol/openid-connect/certs"
  logout_url            = "${var.keycloak_url}/auth/realms/${var.verifiablecredential_realm_name}/protocol/openid-connect/logout"
  client_id             = var.verifiablecredential_client_id
  client_secret         = var.verifiablecredential_client_secret
  tooltip               = "<span>To learn more about using the Verifiable Credential option visit our </span><a href='https://github.com/bcgov/sso-keycloak/wiki/Our-Partners-and-Useful-Information' target='_blank' title='additional information' rel='noreferrer'>additional information.</a>"
  backchannel_supported = false

  post_broker_login_flow_alias = keycloak_authentication_flow.idp_post_login.alias
}

module "verifiablecredential_idp_mappers" {
  source    = "../../idp-attribute-mappers"
  realm_id  = module.realm.id
  idp_alias = module.verifiablecredential_idp.alias
  attributes = local.verifiablecredential_attributes
}

resource "keycloak_custom_identity_provider_mapper" "verifiablecredential_username" {
  realm                    = module.realm.id
  name                     = "username"
  identity_provider_alias  = module.verifiablecredential_idp.alias
  identity_provider_mapper = "oidc-username-idp-mapper"

  extra_config = {
    syncMode = "INHERIT"
    template = "$${CLAIM.preferred_username}@$${ALIAS}"
  }
}
