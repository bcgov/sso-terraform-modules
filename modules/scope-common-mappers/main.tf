resource "keycloak_openid_client_scope" "this" {
  realm_id               = var.realm_id
  name                   = var.scope_name
  description            = "${var.scope_name} client scope"
  include_in_token_scope = false
}

resource "keycloak_generic_client_protocol_mapper" "identity_provider" {
  realm_id        = var.realm_id
  client_scope_id = keycloak_openid_client_scope.this.id
  name            = "identity_provider"
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

resource "keycloak_generic_client_protocol_mapper" "sub_username" {
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

resource "keycloak_generic_client_protocol_mapper" "preferred_username" {
  realm_id        = var.realm_id
  client_scope_id = keycloak_openid_client_scope.this.id
  name            = "preferred_username"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-property-mapper"
  config = {
    "claim.name" : "preferred_username",
    "user.attribute" : "username",
    "id.token.claim" : "true",
    "access.token.claim" : "true",
    "userinfo.token.claim" : "true"
  }
}

resource "keycloak_generic_client_protocol_mapper" "given_name" {
  realm_id        = var.realm_id
  client_scope_id = keycloak_openid_client_scope.this.id
  name            = "given_name"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-property-mapper"
  config = {
    "user.attribute" : "firstName",
    "claim.name" : "given_name",
    "access.token.claim" : "true",
    "id.token.claim" : "true",
    "userinfo.token.claim" : "true",
    "jsonType.label" : "String"
  }
}

resource "keycloak_generic_client_protocol_mapper" "family_name" {
  realm_id        = var.realm_id
  client_scope_id = keycloak_openid_client_scope.this.id
  name            = "family_name"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-property-mapper"
  config = {
    "user.attribute" : "lastName",
    "claim.name" : "family_name",
    "access.token.claim" : "true",
    "id.token.claim" : "true",
    "userinfo.token.claim" : "true",
    "jsonType.label" : "String"
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

resource "keycloak_generic_client_protocol_mapper" "claim_omitter" {
  realm_id        = var.realm_id
  client_scope_id = keycloak_openid_client_scope.this.id
  name            = "claim_omitter"
  protocol        = "openid-connect"
  protocol_mapper = "omit-claim-by-idp-mapper"
  config = {
    "identity_provider_aliases" : "bceidbasic bceidbusiness bceidboth githubpublic githubbcgov",
    "token_claim_names" : "family_name",
    "id.token.claim" : "true",
    "access.token.claim" : "true",
    "userinfo.token.claim" : "true"
  }
}
