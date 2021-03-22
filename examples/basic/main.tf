module "client-vpn-federated-authentication" {
  source = "../../"


  name                   = "${local.name}-vpn"
  description            = "${local.name}-vpn"
  tags                   = local.tags
  domain_name            = "aws.mhmd.io"
  saml_metadata_document = fileexists("../../../config/AWS_Client_VPN.xml") ? file("../../../config/AWS_Client_VPN.xml") : null
  client_cidr_block      = "10.0.99.0/24"
  vpc_id                 = module.vpc.vpc_id
  associated_subnets     = module.vpc.private_subnets
  authorization_rules = [
    {
      name                 = "${local.name}-vpn-azureAD-private1"
      description          = "${local.name}-vpn"
      access_group_id      = null
      authorize_all_groups = true
      target_network_cidr  = module.vpc.private_subnets_cidr_blocks[0]
    },
    {
      name                 = "${local.name}-vpn-azureAD-private2"
      description          = "${local.name}-vpn"
      access_group_id      = null
      authorize_all_groups = true
      target_network_cidr  = module.vpc.private_subnets_cidr_blocks[1]
    },
    {
      name                 = "${local.name}-vpn-azureAD-private3"
      description          = "${local.name}-vpn"
      access_group_id      = null
      authorize_all_groups = true
      target_network_cidr  = module.vpc.private_subnets_cidr_blocks[2]
    }
  ]


}
