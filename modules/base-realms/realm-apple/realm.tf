module "realm" {
  source       = "../../realm"
  realm_name   = var.realm_name
  display_name = "Apple"
}

data "keycloak_authentication_execution" "browser_identity_provider_redirector" {
  realm_id          = module.realm.id
  parent_flow_alias = "browser"
  provider_id       = "identity-provider-redirector"
}

resource "keycloak_authentication_execution_config" "browser_identity_provider_redirector_config" {
  realm_id     = module.realm.id
  execution_id = data.keycloak_authentication_execution.browser_identity_provider_redirector.id
  alias        = var.realm_name
  config = {
    defaultProvider = var.realm_name
  }
}