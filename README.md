# AWS Client VPN Deployment with federated-authentication

Terraform module for aws-client-vpn with federated-authentication

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.45 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.45 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.ca](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_ec2_client_vpn_authorization_rule.rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_network_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_route.additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_route) | resource |
| [aws_iam_saml_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [tls_cert_request.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_routes"></a> [additional\_routes](#input\_additional\_routes) | A list of additional routes that should be attached to the Client VPN endpoint | <pre>list(object({<br>    destination_cidr_block = string<br>    description            = string<br>    target_vpc_subnet_id   = string<br>  }))</pre> | `[]` | no |
| <a name="input_additional_security_groups"></a> [additional\_security\_groups](#input\_additional\_security\_groups) | List of security groups to attach to the client vpn network associations | `list(string)` | `[]` | no |
| <a name="input_associated_subnets"></a> [associated\_subnets](#input\_associated\_subnets) | List of subnets to associate with the VPN endpoint | `list(string)` | n/a | yes |
| <a name="input_authorization_rules"></a> [authorization\_rules](#input\_authorization\_rules) | List of objects describing the authorization rules for the client vpn | <pre>list(object({<br>    name                 = string<br>    access_group_id      = string<br>    authorize_all_groups = bool<br>    description          = string<br>    target_network_cidr  = string<br>  }))</pre> | n/a | yes |
| <a name="input_client_cidr_block"></a> [client\_cidr\_block](#input\_client\_cidr\_block) | VPN CIDR Block | `string` | n/a | yes |
| <a name="input_cloudwatch_log_retention_days"></a> [cloudwatch\_log\_retention\_days](#input\_cloudwatch\_log\_retention\_days) | How long to keep VPN logs. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire. | `number` | `30` | no |
| <a name="input_description"></a> [description](#input\_description) | Resource description | `string` | n/a | yes |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of DNS Server for VPN | `list(string)` | `[]` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain Name to associate with ACM common name | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name to associate with various resources | `string` | n/a | yes |
| <a name="input_saml_metadata_document"></a> [saml\_metadata\_document](#input\_saml\_metadata\_document) | Optional SAML metadata document. Must include this or `saml_provider_arn` | `string` | `null` | no |
| <a name="input_saml_provider_arn"></a> [saml\_provider\_arn](#input\_saml\_provider\_arn) | Optional SAML ARN. Must include this or `saml_metadata_document` | `string` | `null` | no |
| <a name="input_self_service_portal"></a> [self\_service\_portal](#input\_self\_service\_portal) | Specify whether the VPC Client self-service portal is enabled or disabled | `string` | `disabled` | no |
| <a name="input_split_tunnel_enabled"></a> [split\_tunnel\_enabled](#input\_split\_tunnel\_enabled) | Whether to enable split tunnelling | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of strings containing tags for AWS resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of VPC to attach VPN to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sg_id"></a> [sg\_id](#output\_sg\_id) | The ID of the SG for Client VPN. |
| <a name="output_vpn_arn"></a> [vpn\_arn](#output\_vpn\_arn) | The ARN of the Client VPN endpoint. |
| <a name="output_vpn_dns_name"></a> [vpn\_dns\_name](#output\_vpn\_dns\_name) | VPN DNS name |
| <a name="output_vpn_endpoint_security_groups"></a> [vpn\_endpoint\_security\_groups](#output\_vpn\_endpoint\_security\_groups) | VPN endpoint security groups |
| <a name="output_vpn_id"></a> [vpn\_id](#output\_vpn\_id) | The ID of the Client VPN endpoint. |
<!-- END_TF_DOCS -->
