module "realm" {
  source      = "../../realm"
  realm_name  = var.standard_realm_name
  login_theme = "bcgov-idp-stopper"
}

module "idp_auth_flow" {
  source   = "../../idp-stopper-auth-flow"
  realm_id = module.realm.id
}
