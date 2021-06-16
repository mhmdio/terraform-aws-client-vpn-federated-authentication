resource "tls_private_key" "ca" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "ca" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.ca.private_key_pem

  subject {
    common_name  = "ca.vpn.${var.domain_name}"
    organization = var.name
  }

  validity_period_hours = 87600
  is_ca_certificate     = true

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
}

resource "aws_acm_certificate" "ca" {
  private_key      = tls_private_key.ca.private_key_pem
  certificate_body = tls_self_signed_cert.ca.cert_pem
}

resource "tls_private_key" "server" {
  algorithm = "RSA"
}

resource "tls_cert_request" "server" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.server.private_key_pem

  subject {
    common_name  = "server.vpn.${var.domain_name}"
    organization = var.name
  }
}

resource "tls_locally_signed_cert" "server" {
  cert_request_pem   = tls_cert_request.server.cert_request_pem
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = 87600

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "server" {
  private_key       = tls_private_key.server.private_key_pem
  certificate_body  = tls_locally_signed_cert.server.cert_pem
  certificate_chain = tls_self_signed_cert.ca.cert_pem
}

resource "aws_cloudwatch_log_group" "this" {
  name              = var.name
  retention_in_days = var.cloudwatch_log_retention_days
  tags              = var.tags
}

resource "aws_cloudwatch_log_stream" "this" {
  name           = var.name
  log_group_name = aws_cloudwatch_log_group.this.name
}

resource "aws_iam_saml_provider" "this" {
  count                  = var.saml_metadata_document != null ? 1 : 0
  name                   = var.name
  tags                   = var.tags
  saml_metadata_document = var.saml_metadata_document
}

resource "aws_ec2_client_vpn_endpoint" "this" {
  description            = var.description
  client_cidr_block      = var.client_cidr_block
  server_certificate_arn = aws_acm_certificate.server.arn
  split_tunnel           = var.split_tunnel_enabled
  dns_servers            = length(var.dns_servers) > 0 ? var.dns_servers : null

  tags = merge(
    var.tags,
    tomap(
      "Name", var.name,
    )
  )

  authentication_options {
    type              = "federated-authentication"
    saml_provider_arn = try(aws_iam_saml_provider.this[0].arn, var.saml_provider_arn)
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.this.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.this.name
  }
}

resource "aws_security_group" "this" {
  name_prefix = var.name
  description = var.description
  tags        = var.tags
  vpc_id      = var.vpc_id

  ingress {
    description = var.description
    from_port   = 0
    protocol    = -1
    self        = true
    to_port     = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ec2_client_vpn_network_association" "this" {
  for_each               = toset(var.associated_subnets)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  subnet_id              = each.key

  security_groups = concat(
    [aws_security_group.this.id],
    var.additional_security_groups
  )
}

resource "aws_ec2_client_vpn_authorization_rule" "rules" {
  count                  = length(var.authorization_rules)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  access_group_id        = var.authorization_rules[count.index].access_group_id
  authorize_all_groups   = var.authorization_rules[count.index].authorize_all_groups
  description            = var.authorization_rules[count.index].description
  target_network_cidr    = var.authorization_rules[count.index].target_network_cidr

}

resource "aws_ec2_client_vpn_route" "additional" {
  count                  = length(var.additional_routes)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  description            = try(var.additional_routes[count.index].description, var.description)
  destination_cidr_block = var.additional_routes[count.index].destination_cidr_block
  target_vpc_subnet_id   = var.additional_routes[count.index].target_vpc_subnet_id
}
