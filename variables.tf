variable "additional_routes" {
  default     = []
  description = "A list of additional routes that should be attached to the Client VPN endpoint"

  type = list(object({
    destination_cidr_block = string
    description            = string
    target_vpc_subnet_id   = string
  }))
}

variable "additional_security_groups" {
  default     = []
  description = "List of security groups to attach to the client vpn network associations"
  type        = list(string)
}

variable "associated_subnets" {
  type        = list(string)
  description = "List of subnets to associate with the VPN endpoint"
}

variable "authorization_rules" {
  type = list(object({
    name                 = string
    access_group_id      = string
    authorize_all_groups = bool
    description          = string
    target_network_cidr  = string
  }))
  description = "List of objects describing the authorization rules for the client vpn"
}

variable "client_cidr_block" {
  type        = string
  description = "VPN CIDR Block"
}

variable "cloudwatch_log_retention_days" {
  default     = 30
  description = "How long to keep VPN logs. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire."
  type        = number

  validation {
    error_message = "Invalid value. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire."

    condition = (
      contains(
        [
          1,
          3,
          5,
          7,
          14,
          30,
          60,
          90,
          120,
          150,
          180,
          365,
          400,
          545,
          731,
          1827,
          3653,
          0
        ],
        var.cloudwatch_log_retention_days
      )
    )
  }
}

variable "name" {
  description = "Name to associate with various resources"
  type        = string
}

variable "description" {
  description = "Resource description"
  type        = string
}

variable "domain_name" {
  description = "Domain Name to associate with ACM common name"
  type        = string
}

variable "saml_metadata_document" {
  default     = null
  description = "Optional SAML metadata document. Must include this or `saml_provider_arn`"
  type        = string
}

variable "saml_provider_arn" {
  default     = null
  description = "Optional SAML ARN. Must include this or `saml_metadata_document`"
  type        = string
}

variable "self_service_portal" {
  default     = "disabled"
  description = "Optionally specify whether the VPC Client self-service portal is enabled or disabled. Default is disabled"
  type        = string
}

variable "split_tunnel_enabled" {
  default     = true
  description = "Whether to enable split tunnelling"
  type        = bool
}

variable "tags" {
  default     = {}
  description = "Map of strings containing tags for AWS resources"
  type        = map(string)
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC to attach VPN to"
}

variable "dns_servers" {
  type        = list(string)
  description = "List of DNS Server for VPN"
  default     = []
}

variable "transport_protocol" {
  type        = string
  description = "The transport protocol to be used by the VPN session. Default value is `udp`."
  default     = "udp"
}

variable "vpn_port" {
  type        = number
  description = "The port number for the Client VPN endpoint. Valid values are 443 and 1194. Default value is 443."
  default     = 443
}
