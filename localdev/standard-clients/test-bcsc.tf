module "test_bcsc" {
  source      = "../../modules/standard-client"
  realm_id    = var.standard_realm_id
  client_id   = "test-bcsc"
  client_name = "Local Dev for BCSC"
  idps = [
    "common",
    "idir",
    "azureidir",
    "bceidbasic",
    "bceidbusiness",
    "bceidboth",
    "githubpublic",
    "githubbcgov",
    "test-bcsc"
  ]
  standard_flow_enabled      = true
  service_accounts_enabled   = false
  access_type                = "PUBLIC"
  pkce_code_challenge_method = "S256"
  valid_redirect_uris = [
    "https://bcgov.github.io/keycloak-example-apps/*",
    "https://logon7.gov.bc.ca/clp-cgi/logoff.cgi*",
    "https://sso-playground.apps.gold.devops.gov.bc.ca/*"
  ]
  web_origins                  = ["+"]
  override_authentication_flow = true
  browser_authentication_flow  = data.keycloak_authentication_flow.idp_stopper.id
}
