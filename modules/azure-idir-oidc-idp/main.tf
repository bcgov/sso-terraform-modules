module "azureidir_idp" {
  source            = "../oidc-idp"
  realm_id          = var.realm_id
  alias             = var.realm_name
  authorization_url = "https://login.microsoftonline.com/${var.tenant_id}/oauth2/v2.0/authorize"
  token_url         = "https://login.microsoftonline.com/${var.tenant_id}/oauth2/v2.0/token"
  user_info_url     = "https://graph.microsoft.com/oidc/userinfo"
  jwks_url          = "https://login.microsoftonline.com/${var.tenant_id}/discovery/v2.0/keys"
  logout_url        = "https://login.microsoftonline.com/${var.tenant_id}/oauth2/v2.0/logout"
  client_id         = var.client_id
  client_secret     = var.client_secret
}