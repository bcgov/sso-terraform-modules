locals {
  idir_attributes          = ["display_name", "idir_user_guid", "idir_username"]
  azureidir_attributes     = ["display_name", "idir_user_guid", "idir_username"]
  bceidbasic_attributes    = ["display_name", "bceid_user_guid", "bceid_username"]
  bceidbusiness_attributes = ["display_name", "bceid_user_guid", "bceid_business_guid", "bceid_business_name", "bceid_username"]
  bceidboth_attributes     = ["display_name", "bceid_user_guid", "bceid_business_guid", "bceid_business_name", "bceid_username"]
  github_attributes        = ["display_name", "github_id", "github_username", "org_verified", "orgs"]
  githuball_attributes     = ["display_name", "github_id", "github_username", "org_verified", "orgs"]
}

module "realm" {
  source       = "../../realm"
  realm_name   = var.standard_realm_name
  display_name = "Single Sign-On"
  login_theme  = "bcgov-idp-stopper"
}

module "idp_auth_flow" {
  source   = "../../idp-stopper-auth-flow"
  realm_id = module.realm.id
}

module "github_org_verification_auth_flow" {
  source          = "../../attribute-authenticator-auth-flow"
  realm_id        = module.realm.id
  auth_flow_alias = "github org verification"
}

resource "keycloak_authentication_execution_config" "github_org_verification_auth_flow_exec1_config" {
  realm_id     = module.realm.id
  execution_id = module.github_org_verification_auth_flow.flow_exec1_id
  alias        = "${module.github_org_verification_auth_flow.flow_exec1_authenticator}-config"
  config = {
    attributeKey   = "org_verified",
    attributeValue = "true",
    errorUrl       = "https://github.com/bcgov/sso-keycloak/wiki/Are-you-part-of-the-GitHub-BC-Gov-Org-%3F"
  }
}

resource "keycloak_openid_client" "logout_redirect_uri_delegator" {
  realm_id = module.realm.id

  client_id   = "logout-redirect-uri-delegator"
  name        = "logout redirect uri delegator"
  description = "this client allows all post-logout redirect URIs"

  enabled                      = true
  standard_flow_enabled        = true
  implicit_flow_enabled        = false
  direct_access_grants_enabled = false
  service_accounts_enabled     = false

  access_type = "CONFIDENTIAL"

  root_url            = ""
  valid_redirect_uris = ["*"]
  web_origins         = []
}
