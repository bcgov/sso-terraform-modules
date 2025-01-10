terraform {
  required_version = ">= 1.1.4"

  required_providers {
    keycloak = {
      source  = "keycloak/keycloak"
      version = "4.5.0"
    }
  }
}
