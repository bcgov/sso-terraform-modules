module "sandbox_client" {
  source              = "../../standard-idp-client"
  realm_id            = module.realm.id
  client_id           = "${var.sandbox_client_id}"
  valid_redirect_uris = ["${var.keycloak_url}/auth/realms/${var.sandbox_client_id}/broker/${var.realm_name}/endpoint"]
  public_attrs        = []
}
