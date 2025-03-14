module "standard_client" {
  source       = "../../standard-idp-client"
  realm_id     = module.realm.id
  client_id    = "${var.standard_realm_name}-realm"
  public_attrs = ["email"]
  valid_redirect_uris = [
    "${var.keycloak_url}/auth/realms/${var.standard_realm_name}/broker/${var.realm_name}public/endpoint",
    "${var.keycloak_url}/auth/realms/${var.standard_realm_name}/broker/${var.realm_name}bcgov/endpoint"
  ]
  sub_to_username = var.sub_to_username
}
