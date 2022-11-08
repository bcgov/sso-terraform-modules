module "bceidboth_idp" {
  source            = "../../oidc-idp"
  realm_id          = module.realm.id
  alias             = var.bceidboth_realm_name
  display_name      = "Basic or Business BCeID"
  authorization_url = "${var.keycloak_url}/auth/realms/${var.bceidboth_realm_name}/protocol/openid-connect/auth"
  token_url         = "${var.keycloak_url}/auth/realms/${var.bceidboth_realm_name}/protocol/openid-connect/token"
  user_info_url     = "${var.keycloak_url}/auth/realms/${var.bceidboth_realm_name}/protocol/openid-connect/userinfo"
  jwks_url          = "${var.keycloak_url}/auth/realms/${var.bceidboth_realm_name}/protocol/openid-connect/certs"
  logout_url        = "${var.keycloak_url}/auth/realms/${var.bceidboth_realm_name}/protocol/openid-connect/logout"
  client_id         = var.bceidboth_client_id
  client_secret     = var.bceidboth_client_secret

  post_broker_login_flow_alias = keycloak_authentication_flow.idp_post_login.alias
}

module "bceidboth_idp_mappers" {
  source    = "../../idp-attribute-mappers"
  realm_id  = module.realm.id
  idp_alias = module.bceidboth_idp.alias

  attributes = local.bceidboth_attributes
}

resource "keycloak_custom_identity_provider_mapper" "bceidboth_username" {
  realm                    = module.realm.id
  name                     = "username"
  identity_provider_alias  = module.bceidboth_idp.alias
  identity_provider_mapper = "oidc-username-idp-mapper"

  extra_config = {
    syncMode = "INHERIT"
    template = "$${CLAIM.preferred_username}@$${ALIAS}"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bceidboth_first_name" {
  realm                    = module.realm.id
  name                     = "first_name"
  identity_provider_alias  = module.bceidboth_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode = "FORCE"
    "attribute" : "firstName"
    "user.attribute" : "firstName"
    "claim" : "display_name"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bceidboth_last_name" {
  realm                    = module.realm.id
  name                     = "last_name"
  identity_provider_alias  = module.bceidboth_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode = "FORCE"
    "attribute" : "lastName"
    "user.attribute" : "lastName"
    "claim" : "bceid_username"
  }
}
