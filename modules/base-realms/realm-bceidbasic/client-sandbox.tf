module "sandbox_client" {
  source              = "../../sandbox-idp-client-saml"
  realm_id            = module.realm.id
  client_id           = "${var.keycloak_url}/auth/realms/${var.realm_name}"
  valid_redirect_uris = ["${var.keycloak_url}/auth/realms/${var.realm_name}/broker/${var.realm_name}/endpoint"]
  attributes          = ["display_name", "bceid_user_guid", "bceid_username"]
}
