data "keycloak_realm" "master" {
  realm = "master"
}

module "idp_client" {
  source              = "../standard-idp-client"
  realm_id            = var.idp_realm_id
  client_id           = "master-realm"
  valid_redirect_uris = ["${var.keycloak_url}/auth/realms/master/broker/${var.idp_realm_name}/endpoint"]
  public_attrs        = var.idp_public_attrs
}

module "idp_auth_flow" {
  source   = "../otp-auth-flow"
  realm_id = data.keycloak_realm.master.id
}

module "master_idp" {
  source                       = "../oidc-idp"
  realm_id                     = data.keycloak_realm.master.id
  alias                        = var.idp_realm_name
  authorization_url            = "${var.keycloak_url}/auth/realms/${var.idp_realm_name}/protocol/openid-connect/auth"
  token_url                    = "${var.keycloak_url}/auth/realms/${var.idp_realm_name}/protocol/openid-connect/token"
  user_info_url                = "${var.keycloak_url}/auth/realms/${var.idp_realm_name}/protocol/openid-connect/userinfo"
  jwks_url                     = "${var.keycloak_url}/auth/realms/${var.idp_realm_name}/protocol/openid-connect/certs"
  post_broker_login_flow_alias = var.otp_required == true ? module.idp_auth_flow.flow_alias : ""
  client_id                    = module.idp_client.client_id
  client_secret                = module.idp_client.client_secret
}
