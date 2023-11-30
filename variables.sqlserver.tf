variable "server_version" {
  description = "The version for the server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server). Changing this forces a new resource to be created."
  default     = "12.0"
}

variable "administrator_login" {

}

variable "administrator_login_password" {

}

variable "connection_policy" {
  default = "Default"
}

variable "azuread_administrator" {
  description = "Azure AD Administrator Configuration"

  type = object({
    login_username              = optional(string)
    object_id                   = optional(string)
    tenant_id                   = optional(string)
    azuread_authentication_only = optional(bool)
  })

  default = {}
}

variable "public_network_access_enabled" {
  default = false
}

variable "outbound_network_restriction_enabled" {
  default = true
}

variable "primary_user_assigned_identity_id" {
  default = null
}

variable "transparent_data_encryption_key_vault_key_id" {
  default = null
}
