resource "keycloak_openid_client_scope" "this" {
  realm_id               = var.realm_id
  name                   = var.scope_name
  description            = "${var.scope_name} client scope"
  include_in_token_scope = false
}

resource "keycloak_generic_client_protocol_mapper" "identity_provider_mapper" {
  realm_id        = var.realm_id
  client_scope_id = keycloak_openid_client_scope.this.id
  name            = "IDP"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usersessionmodel-note-mapper"
  config = {
    "user.session.note" : "identity_provider",
    "claim.name" : "identity_provider",
    "jsonType.label" : "String",
    "id.token.claim" : "true",
    "access.token.claim" : "true",
    "access.tokenResponse.claim" : "false"
  }
}

resource "keycloak_generic_client_protocol_mapper" "sub_mapper" {
  realm_id        = var.realm_id
  client_scope_id = keycloak_openid_client_scope.this.id
  name            = "sub_username"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-property-mapper"
  config = {
    "claim.name" : "sub",
    "user.attribute" : "username",
    "id.token.claim" : "true",
    "access.token.claim" : "true",
    "userinfo.token.claim" : "true"
  }
}

resource "keycloak_generic_client_protocol_mapper" "name" {
  realm_id        = var.realm_id
  client_scope_id = keycloak_openid_client_scope.this.id
  name            = "name"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-attribute-mapper"
  config = {
    "user.attribute" : "display_name",
    "claim.name" : "name",
    "id.token.claim" : "true",
    "access.token.claim" : "true",
    "userinfo.token.claim" : "true",
    "multivalued" : "",
    "aggregate.attrs" : ""
  }
}
