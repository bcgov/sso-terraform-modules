# TODO: This will have some fairly extensive changes as we test the integration 
# The Azure IDIR configuration has been commented out
module "microsoft_idp" {
  source                = "../../oidc-idp"
  realm_id              = module.realm.id
  alias                 = var.realm_name
  authorization_url     = var.microsoft_tenant_id != "" ? "https://login.microsoftonline.com/${var.microsoft_tenant_id}/oauth2/v2.0/authorize" : var.authorization_url
  token_url             = var.microsoft_tenant_id != "" ? "https://login.microsoftonline.com/${var.microsoft_tenant_id}/oauth2/v2.0/token" : var.token_url
  user_info_url         = var.user_info_url != "" ? var.user_info_url : "https://graph.microsoft.com/oidc/userinfo"
  jwks_url              = var.microsoft_tenant_id != "" ? "https://login.microsoftonline.com/${var.microsoft_tenant_id}/discovery/v2.0/keys" : var.jwks_url
  logout_url            = var.microsoft_tenant_id != "" ? "https://login.microsoftonline.com/${var.microsoft_tenant_id}/oauth2/v2.0/logout" : var.logout_url
  client_id             = var.microsoft_client_id
  client_secret         = var.microsoft_client_secret
  default_scopes        = "openid"
  disable_user_info     = true
  backchannel_supported = false
}

resource "keycloak_custom_identity_provider_mapper" "microsoft_first_name" {
  realm                    = module.realm.id
  name                     = "first_name"
  identity_provider_alias  = module.microsoft_idp.alias
  identity_provider_mapper = "hardcoded-attribute-idp-mapper"

  extra_config = {
    syncMode = "FORCE"
    "attribute" : "firstName"
    "attribute.value" : ""
  }
}

resource "keycloak_custom_identity_provider_mapper" "microsoft_last_name" {
  realm                    = module.realm.id
  name                     = "last_name"
  identity_provider_alias  = module.microsoft_idp.alias
  identity_provider_mapper = "hardcoded-attribute-idp-mapper"

  extra_config = {
    syncMode = "FORCE"
    "attribute" : "lastName"
    "attribute.value" : ""
  }
}

resource "keycloak_custom_identity_provider_mapper" "microsoft_email" {
  realm                    = module.realm.id
  name                     = "email"
  identity_provider_alias  = module.microsoft_idp.alias
  identity_provider_mapper = "hardcoded-attribute-idp-mapper"

  extra_config = {
    syncMode = "FORCE"
    "attribute" : "email"
    "attribute.value" : ""
  }
}

resource "keycloak_custom_identity_provider_mapper" "sub_username" {
  realm                    = module.realm.id
  name                     = "username"
  identity_provider_alias  = module.microsoft_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode = "FORCE"
    "user.attribute": "username"
    claim = "sub"
  }
}