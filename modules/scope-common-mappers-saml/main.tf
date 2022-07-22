resource "keycloak_saml_client_scope" "this" {
  realm_id    = var.realm_id
  name        = "${var.scope_name}-saml"
  description = "${var.scope_name} client scope"
}

resource "keycloak_generic_client_protocol_mapper" "identity_provider_mapper" {
  realm_id        = var.realm_id
  client_scope_id = keycloak_saml_client_scope.this.id

  name            = "IDP"
  protocol        = "saml"
  protocol_mapper = "saml-user-session-note-mapper"
  config = {
    "note" : "identity_provider",
    "attribute.name" : "identity_provider"
  }
}

resource "keycloak_generic_client_protocol_mapper" "nameid_mapper" {
  realm_id        = var.realm_id
  client_scope_id = keycloak_saml_client_scope.this.id
  name            = "nameid_username"
  protocol        = "saml"
  protocol_mapper = "saml-user-attribute-nameid-mapper"
  config = {
    "mapper.nameid.format" : "urn:oasis:names:tc:SAML:2.0:nameid-format:persistent",
    "user.attribute" : "username"
  }
}
