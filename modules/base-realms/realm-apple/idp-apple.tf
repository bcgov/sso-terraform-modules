module "apple_idp" {
  source                = "../../oidc-idp"
  realm_id              = module.realm.id
  alias                 = var.realm_name
  authorization_url     = "https://appleid.apple.com/auth/authorize"
  token_url             = "https://appleid.apple.com/auth/token"
  jwks_url              = "https://appleid.apple.com/auth/keys"
  client_id             = var.apple_client_id
  client_secret         = var.apple_client_secret
  default_scopes        = "openid"
  backchannel_supported = false
  disable_user_info     = true
  idp_extra_config      = {
    clientAssertionSigningAlg = "ES256"
  }
}
