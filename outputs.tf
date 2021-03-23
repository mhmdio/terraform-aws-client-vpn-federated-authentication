output "sg_id" {
  description = "The ID of the SG for Client VPN."
  value       = aws_security_group.this.id
}

output "vpn_id" {
  description = "The ID of the Client VPN endpoint."
  value       = aws_ec2_client_vpn_endpoint.this.id
}

output "vpn_arn" {
  description = "The ARN of the Client VPN endpoint."
  value       = aws_ec2_client_vpn_endpoint.this.arn
}

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
