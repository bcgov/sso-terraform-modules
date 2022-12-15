module "sandbox_client" {
  source              = "../../standard-idp-client"
  realm_id            = module.realm.id
  client_id           = var.sandbox_client_id
  valid_redirect_uris = ["${var.sandbox_keycloak_url}/auth/realms/${var.sandbox_client_id}/broker/${var.realm_name}/endpoint"]
  public_attrs        = ["display_name", "idir_user_guid", "idir_username"]
  sub_to_username     = var.sub_to_username
}
