module "standard_client" {
  source              = "../../standard-idp-client"
  realm_id            = module.realm.id
  client_id           = "${var.standard_realm_name}-realm"
  valid_redirect_uris = ["${var.keycloak_url}/auth/realms/${var.standard_realm_name}/broker/${var.realm_name}/endpoint"]
  public_attrs        = ["vc_presented_attributes", "pres_req_conf_id"]
  sub_to_username     = var.sub_to_username
}
