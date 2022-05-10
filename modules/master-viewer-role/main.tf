data "keycloak_realm" "master" {
  realm = "master"
}

data "keycloak_openid_client" "clients" {
  for_each = toset(var.realm_names)

  realm_id  = data.keycloak_realm.master.id
  client_id = "${each.key}-realm"
}

data "keycloak_role" "view_realm" {
  for_each = toset(var.realm_names)

  realm_id  = data.keycloak_realm.master.id
  client_id = data.keycloak_openid_client.clients[each.key].id
  name      = "view-realm"
}

data "keycloak_role" "view_users" {
  for_each = toset(var.realm_names)

  realm_id  = data.keycloak_realm.master.id
  client_id = data.keycloak_openid_client.clients[each.key].id
  name      = "view-users"
}

data "keycloak_role" "view_clients" {
  for_each = toset(var.realm_names)

  realm_id  = data.keycloak_realm.master.id
  client_id = data.keycloak_openid_client.clients[each.key].id
  name      = "view-clients"
}

data "keycloak_role" "view_events" {
  for_each = toset(var.realm_names)

  realm_id  = data.keycloak_realm.master.id
  client_id = data.keycloak_openid_client.clients[each.key].id
  name      = "view-events"
}

data "keycloak_role" "view_identity_providers" {
  for_each = toset(var.realm_names)

  realm_id  = data.keycloak_realm.master.id
  client_id = data.keycloak_openid_client.clients[each.key].id
  name      = "view-identity-providers"
}

data "keycloak_role" "view_authorization" {
  for_each = toset(var.realm_names)

  realm_id  = data.keycloak_realm.master.id
  client_id = data.keycloak_openid_client.clients[each.key].id
  name      = "view-authorization"
}

resource "keycloak_role" "viewer" {
  realm_id = data.keycloak_realm.master.id
  name     = "viewer"

  composite_roles = concat(
    [for v in values(data.keycloak_role.view_realm) : v.id],
    [for v in values(data.keycloak_role.view_users) : v.id],
    [for v in values(data.keycloak_role.view_clients) : v.id],
    [for v in values(data.keycloak_role.view_events) : v.id],
    [for v in values(data.keycloak_role.view_identity_providers) : v.id],
    [for v in values(data.keycloak_role.view_authorization) : v.id]
  )
}
