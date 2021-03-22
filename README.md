# AWS Client VPM Deployment with federated-authentication

Terraform module for aws-client-vpn with federated-authentication

## Requirements

| Name      | Version   |
| --------- | --------- |
| terraform | ~> 0.14.0 |
| aws       | ~> 3.32   |
| tls       | ~> 3.1.0  |

## Providers

| Name | Version  |
| ---- | -------- |
| aws  | ~> 3.32  |
| tls  | ~> 3.1.0 |

## Modules

No Modules.

## Resources

| Name                                                                                                                                                     |
| -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [aws_acm_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate)                                       |
| [aws_cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group)                             |
| [aws_cloudwatch_log_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream)                           |
| [aws_ec2_client_vpn_authorization_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule)   |
| [aws_ec2_client_vpn_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint)                       |
| [aws_ec2_client_vpn_network_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association) |
| [aws_ec2_client_vpn_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_route)                             |
| [aws_iam_saml_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider)                                   |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                                         |
| [tls_cert_request](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request)                                             |
| [tls_locally_signed_cert](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert)                               |
| [tls_private_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key)                                               |
| [tls_self_signed_cert](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert)                                     |

## Inputs

| Name                             | Description                                                                                                                                                                                                          | Type                                                                                                                                                                                                                     | Default | Required |
| -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------- | :------: |
| additional\_routes               | A list of additional routes that should be attached to the Client VPN endpoint                                                                                                                                       | <pre>list(object({<br>    destination_cidr_block = string<br>    description            = string<br>    target_vpc_subnet_id   = string<br>  }))</pre>                                                                   | `[]`    |    no    |
| additional\_security\_groups     | List of security groups to attach to the client vpn network associations                                                                                                                                             | `list(string)`                                                                                                                                                                                                           | `[]`    |    no    |
| associated\_subnets              | List of subnets to associate with the VPN endpoint                                                                                                                                                                   | `list(string)`                                                                                                                                                                                                           | n/a     |   yes    |
| authorization\_rules             | List of objects describing the authorization rules for the client vpn                                                                                                                                                | <pre>list(object({<br>    name                 = string<br>    access_group_id      = string<br>    authorize_all_groups = bool<br>    description          = string<br>    target_network_cidr  = string<br>  }))</pre> | n/a     |   yes    |
| client\_cidr\_block              | VPN CIDR Block                                                                                                                                                                                                       | `string`                                                                                                                                                                                                                 | n/a     |   yes    |
| cloudwatch\_log\_retention\_days | How long to keep VPN logs. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire. | `number`                                                                                                                                                                                                                 | `30`    |    no    |
| description                      | Resource description                                                                                                                                                                                                 | `string`                                                                                                                                                                                                                 | n/a     |   yes    |
| domain\_name                     | Domain Name to associate with ACM common name                                                                                                                                                                        | `string`                                                                                                                                                                                                                 | n/a     |   yes    |
| name                             | Name to associate with various resources                                                                                                                                                                             | `string`                                                                                                                                                                                                                 | n/a     |   yes    |
| saml\_metadata\_document         | Optional SAML metadata document. Must include this or `saml_provider_arn`                                                                                                                                            | `string`                                                                                                                                                                                                                 | `null`  |    no    |
| saml\_provider\_arn              | Optional SAML ARN. Must include this or `saml_metadata_document`                                                                                                                                                     | `string`                                                                                                                                                                                                                 | `null`  |    no    |
| split\_tunnel\_enabled           | Whether to enable split tunnelling                                                                                                                                                                                   | `bool`                                                                                                                                                                                                                   | `true`  |    no    |
| tags                             | Map of strings containing tags for AWS resources                                                                                                                                                                     | `map(string)`                                                                                                                                                                                                            | `{}`    |    no    |
| vpc\_id                          | ID of VPC to attach VPN to                                                                                                                                                                                           | `string`                                                                                                                                                                                                                 | n/a     |   yes    |

## Outputs

| Name                            | Description                  |
| ------------------------------- | ---------------------------- |
| vpn\_dns\_name                  | VPN DNS name                 |
| vpn\_endpoint\_security\_groups | VPN endpoint security groups |