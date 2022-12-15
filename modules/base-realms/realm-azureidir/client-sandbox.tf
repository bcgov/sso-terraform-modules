module "sandbox_client" {
  source              = "../../standard-idp-client"
  realm_id            = module.realm.id
  client_id           = "sandbox-client"
  valid_redirect_uris = [var.sandbox_client_redirect_uri]
  public_attrs        = ["display_name", "idir_user_guid", "idir_username"]
  sub_to_username     = var.sub_to_username
}
