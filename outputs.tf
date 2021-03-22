output "vpn_dns_name" {
  description = "VPN DNS name"
  value       = aws_ec2_client_vpn_endpoint.this.dns_name
}

output "vpn_endpoint_security_groups" {
  description = "VPN endpoint security groups"

  value = distinct(
    flatten(
      [for association in aws_ec2_client_vpn_network_association.this : association.security_groups]
    )
  )
}
