module "verifiablecredential_idp" {
  source                = "../../oidc-idp"
  realm_id              = module.realm.id
  alias                 = var.realm_name
  authorization_url     = var.authorization_url
  token_url             = var.token_url
  client_id             = var.verifiablecredential_client_id
  client_secret         = var.verifiablecredential_client_secret
  client_auth_method    = "client_secret_basic"
  validate_signature    = false
  forwardParameters     = "pres_req_conf_id"
  default_scopes        = "vc_authn"
  backchannel_supported = false
}

resource "keycloak_custom_identity_provider_mapper" "verifiablecredential_vc_presented_attributes" {
  realm                    = module.realm.id
  name                     = "vc_presented_attributes"
  identity_provider_alias  = module.verifiablecredential_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "vc_presented_attributes"
    "user.attribute" = "vc_presented_attributes"
  }
}

resource "keycloak_custom_identity_provider_mapper" "verifiablecredential_pres_req_conf_id" {
  realm                    = module.realm.id
  name                     = "pres_req_conf_id"
  identity_provider_alias  = module.verifiablecredential_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "pres_req_conf_id"
    "user.attribute" = "pres_req_conf_id"
  }
}


