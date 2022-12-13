module "sandbox_saml_client" {
  source = "../saml-client"

  realm_id = var.realm_id

  client_id   = var.client_id
  name        = var.client_name
  description = var.description
  login_theme = var.login_theme

  enabled = var.enabled

  valid_redirect_uris = var.valid_redirect_uris
  assertion_lifespan  = var.assertion_lifespan
  client_signature_required = var.client_signature_required

  override_authentication_flow = var.override_authentication_flow
  browser_authentication_flow  = var.browser_authentication_flow
}