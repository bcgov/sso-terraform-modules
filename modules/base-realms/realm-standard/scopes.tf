module "common_scope_mappers" {
  source     = "../../scope-common-mappers"
  realm_id   = module.realm.id
  scope_name = "common"
}

module "idir_scope_mappers" {
  source     = "../../scope-attribute-mappers"
  realm_id   = module.realm.id
  scope_name = var.idir_realm_name
  attributes = local.idir_attributes
}

module "azureidir_scope_mappers" {
  source     = "../../scope-attribute-mappers"
  realm_id   = module.realm.id
  scope_name = var.azureidir_realm_name
  attributes = local.azureidir_attributes
}

module "bceidbasic_scope_mappers" {
  source     = "../../scope-attribute-mappers"
  realm_id   = module.realm.id
  scope_name = var.bceidbasic_realm_name
  attributes = local.bceidbasic_attributes
}

module "bceidbusiness_scope_mappers" {
  source     = "../../scope-attribute-mappers"
  realm_id   = module.realm.id
  scope_name = var.bceidbusiness_realm_name
  attributes = local.bceidbusiness_attributes
}

module "bceidboth_scope_mappers" {
  source     = "../../scope-attribute-mappers"
  realm_id   = module.realm.id
  scope_name = var.bceidboth_realm_name
  attributes = local.bceidboth_attributes
}

module "githubpublic_scope_mappers" {
  source     = "../../scope-attribute-mappers"
  realm_id   = module.realm.id
  scope_name = "${var.github_realm_name}public"
  attributes = local.githubpublic_attributes
}

resource "keycloak_generic_client_protocol_mapper" "githubpublic_scope_name" {
  realm_id        = module.realm.id
  client_scope_id = module.githubpublic_scope_mappers.client_scope_id

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

module "githubbcgov_scope_mappers" {
  source     = "../../scope-attribute-mappers"
  realm_id   = module.realm.id
  scope_name = "${var.github_realm_name}bcgov"
  attributes = local.githubbcgov_attributes
}

resource "keycloak_generic_client_protocol_mapper" "githubbcgov_scope_name" {
  realm_id        = module.realm.id
  client_scope_id = module.githubbcgov_scope_mappers.client_scope_id

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
