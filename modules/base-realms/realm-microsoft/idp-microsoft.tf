# Jonathan TODO This needs to get rewritten to point at the new microsoft integration
module "microsoft_idp" {
  source                = "../../oidc-idp"
  realm_id              = module.realm.id
  alias                 = var.realm_name
  authorization_url     = ""#var.microsoft_tenant_id != "" ? "https://login.microsoftonline.com/${var.microsoft_tenant_id}/oauth2/v2.0/authorize" : var.authorization_url
  token_url             = ""#var.microsoft_tenant_id != "" ? "https://login.microsoftonline.com/${var.microsoft_tenant_id}/oauth2/v2.0/token" : var.token_url
  user_info_url         = ""#var.user_info_url != "" ? var.user_info_url : "https://graph.microsoft.com/oidc/userinfo"
  jwks_url              = ""#var.microsoft_tenant_id != "" ? "https://login.microsoftonline.com/${var.microsoft_tenant_id}/discovery/v2.0/keys" : var.jwks_url
  logout_url            = ""#var.microsoft_tenant_id != "" ? "https://login.microsoftonline.com/${var.microsoft_tenant_id}/oauth2/v2.0/logout" : var.logout_url
  client_id             = ""#var.microsoft_client_id
  client_secret         = ""#var.microsoft_client_secret
  default_scopes        = "openid profile email"
  backchannel_supported = false
}

# resource "keycloak_custom_identity_provider_mapper" "azureidir_firstname" {
#   realm                    = module.realm.id
#   name                     = "first_name"
#   identity_provider_alias  = module.azureidir_idp.alias
#   identity_provider_mapper = "oidc-user-attribute-idp-mapper"

#   extra_config = {
#     syncMode         = "INHERIT"
#     "claim"          = "given_name"
#     "user.attribute" = "firstName"
#   }
# }

# resource "keycloak_custom_identity_provider_mapper" "azureidir_lastname" {
#   realm                    = module.realm.id
#   name                     = "last_name"
#   identity_provider_alias  = module.azureidir_idp.alias
#   identity_provider_mapper = "oidc-user-attribute-idp-mapper"

#   extra_config = {
#     syncMode         = "INHERIT"
#     "claim"          = "family_name"
#     "user.attribute" = "lastName"
#   }
# }

# resource "keycloak_custom_identity_provider_mapper" "azureidir_displayname" {
#   realm                    = module.realm.id
#   name                     = "display_name"
#   identity_provider_alias  = module.azureidir_idp.alias
#   identity_provider_mapper = "oidc-user-attribute-idp-mapper"

#   extra_config = {
#     syncMode         = "INHERIT"
#     "claim"          = "name"
#     "user.attribute" = "display_name"
#   }
# }

resource "keycloak_custom_identity_provider_mapper" "microsoft_email" {
  realm                    = module.realm.id
  name                     = "email"
  identity_provider_alias  = module.microsoft_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "email"
    "user.attribute" = "email"
  }
}


# # see https://docs.microsoft.com/en-us/azure/active-directory/develop/id-tokens#using-claims-to-reliably-identify-a-user-subject-and-object-id
# resource "keycloak_custom_identity_provider_mapper" "azureidir_username" {
#   realm                    = module.realm.id
#   name                     = "username"
#   identity_provider_alias  = module.azureidir_idp.alias
#   identity_provider_mapper = "oidc-username-idp-mapper"

#   extra_config = {
#     syncMode = "INHERIT"
#     template = "$${CLAIM.bcgovGUID}"
#   }
# }
