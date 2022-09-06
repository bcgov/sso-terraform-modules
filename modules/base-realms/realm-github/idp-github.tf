# since the Keycloak provider does not support GitHub social provider, use generic OIDC resource.
resource "keycloak_oidc_identity_provider" "github" {
  realm       = module.realm.id
  provider_id = "github-custom"
  alias       = var.realm_name

  enabled     = true
  store_token = false
  sync_mode   = "FORCE"

  client_id     = var.client_id
  client_secret = var.client_secret

  first_broker_login_flow_alias = "first broker login"
  post_broker_login_flow_alias  = ""

  default_scopes = "user:email user:profile read:org"

  # these values are not required for GitHub provider, but have them here as required for OIDC.
  authorization_url = ""
  token_url         = ""

  extra_config = {
    "githubOrg" = "bcgov"
  }
}

resource "keycloak_custom_identity_provider_mapper" "github_display_name" {
  realm                    = module.realm.id
  name                     = "display_name"
  identity_provider_alias  = keycloak_oidc_identity_provider.github.alias
  identity_provider_mapper = "github-custom-user-attribute-mapper"

  extra_config = {
    syncMode        = "FORCE"
    "jsonField"     = "name"
    "userAttribute" = "display_name"
  }
}

resource "keycloak_custom_identity_provider_mapper" "github_username" {
  realm                    = module.realm.id
  name                     = "github_username"
  identity_provider_alias  = keycloak_oidc_identity_provider.github.alias
  identity_provider_mapper = "github-custom-user-attribute-mapper"

  extra_config = {
    syncMode        = "FORCE"
    "jsonField"     = "login"
    "userAttribute" = "github_username"
  }
}
