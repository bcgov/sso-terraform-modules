locals {
  idir_attributes          = ["display_name", "idir_user_guid", "idir_username"]
  azureidir_attributes     = ["display_name", "idir_user_guid", "idir_username"]
  bceidbasic_attributes    = ["display_name", "bceid_user_guid", "bceid_username"]
  bceidbusiness_attributes = ["display_name", "bceid_user_guid", "bceid_business_guid", "bceid_business_name", "bceid_username"]
  bceidboth_attributes     = ["display_name", "bceid_user_guid", "bceid_business_guid", "bceid_business_name", "bceid_username"]
  github_attributes        = ["display_name", "github_username"]
}

module "realm" {
  source      = "../../realm"
  realm_name  = var.standard_realm_name
  login_theme = "bcgov-idp-stopper"
}

module "idp_auth_flow" {
  source   = "../../idp-stopper-auth-flow"
  realm_id = module.realm.id
}
