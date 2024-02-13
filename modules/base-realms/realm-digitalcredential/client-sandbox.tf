resource "keycloak_openid_client" "digitalcredential_sandbox_client" {
  realm_id = module.realm.id

  client_id = "sandbox-client"
  name      = "sandbox-client"

  enabled                      = true
  standard_flow_enabled        = true
  implicit_flow_enabled        = false
  direct_access_grants_enabled = false
  service_accounts_enabled     = false

  access_type = "CONFIDENTIAL"

  valid_redirect_uris = [var.sandbox_client_redirect_uri]
  web_origins         = []
}

resource "keycloak_generic_protocol_mapper" "sandbox_client_mapper_pres_req_conf_id" {
  realm_id  = module.realm.id
  client_id = keycloak_openid_client.digitalcredential_sandbox_client.id

  name            = "pres_req_conf_id"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-attribute-mapper"
  config = {
    "user.attribute" : "pres_req_conf_id",
    "claim.name" : "pres_req_conf_id",
    "jsonType.label" : "String",
    "id.token.claim" : "true",
    "access.token.claim" : "true",
    "userinfo.token.claim" : "true"
  }
}

resource "keycloak_generic_protocol_mapper" "sandbox_client_mapper_vc_presented_attributes" {
  realm_id  = module.realm.id
  client_id = keycloak_openid_client.digitalcredential_sandbox_client.id

  name            = "vc_presented_attributes"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-attribute-mapper"
  config = {
    "user.attribute" : "vc_presented_attributes",
    "claim.name" : "vc_presented_attributes",
    "jsonType.label" : "String",
    "id.token.claim" : "true",
    "access.token.claim" : "true",
    "userinfo.token.claim" : "true"
  }
}
