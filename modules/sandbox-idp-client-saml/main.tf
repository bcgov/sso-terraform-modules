module "sandbox_idp_client_saml" {
  source = "../saml-client"

  realm_id = var.realm_id

  client_id   = var.client_id
  name        = var.client_name
  description = var.description
  login_theme = var.login_theme

  enabled = var.enabled

  valid_redirect_uris          = var.valid_redirect_uris
  assertion_lifespan           = var.assertion_lifespan
  client_signature_required    = var.client_signature_required
  encrypt_assertions           = var.encrypt_assertions
  override_authentication_flow = var.override_authentication_flow
  browser_authentication_flow  = var.browser_authentication_flow
}

resource "keycloak_generic_client_protocol_mapper" "sandbox_idp_client_attribute_mappers" {
  for_each = toset(var.attributes)

  realm_id  = var.realm_id
  client_id = module.sandbox_idp_client_saml.id

  name            = each.key
  protocol        = "saml"
  protocol_mapper = "saml-user-attribute-mapper"
  config = {
    "attribute.name"       = each.key
    "attribute.nameformat" = "Basic"
    "attribute.value"      = each.key
    "friendly.name"        = each.key
  }
}
