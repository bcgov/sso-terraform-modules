module "standard_client" {
  source              = "../../standard-idp-client"
  realm_id            = module.realm.id
  client_id           = "${var.standard_realm_name}-realm"
  valid_redirect_uris = [
    "${var.keycloak_url}/auth/realms/${var.standard_realm_name}/broker/${var.realm_name}/endpoint", 
    "${var.keycloak_url}/auth/realms/${var.standard_realm_name}/broker/${var.realm_name}/endpoint/logout_response"
]
  public_attrs        = []
  sub_to_username     = var.sub_to_username
}
