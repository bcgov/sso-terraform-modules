resource "keycloak_authentication_flow" "this" {
  realm_id = var.realm_id
  alias    = "client stopper"
}

resource "keycloak_authentication_execution" "exec1" {
  realm_id          = var.realm_id
  parent_flow_alias = keycloak_authentication_flow.this.alias
  authenticator     = "user-session-remover"
  requirement       = "ALTERNATIVE"
}

resource "keycloak_authentication_execution" "exec2" {
  realm_id          = var.realm_id
  parent_flow_alias = keycloak_authentication_flow.this.alias
  authenticator     = "cookie-stopper"
  requirement       = "ALTERNATIVE"
  depends_on        = [keycloak_authentication_execution.exec1]
}

resource "keycloak_authentication_execution" "exec3" {
  realm_id          = var.realm_id
  parent_flow_alias = keycloak_authentication_flow.this.alias
  authenticator     = "identity-provider-stopper"
  requirement       = "ALTERNATIVE"
  depends_on        = [keycloak_authentication_execution.exec2]
}


resource "keycloak_authentication_execution" "exec4" {
  realm_id          = var.realm_id
  parent_flow_alias = keycloak_authentication_flow.this.alias
  authenticator     = "identity-provider-stop-form"
  requirement       = "ALTERNATIVE"
  depends_on        = [keycloak_authentication_execution.exec3]
}
