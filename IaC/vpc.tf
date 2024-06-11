resource "aws_eip" "nat" {
  count = length(var.vpc_public_subnet_names)

  domain = "vpc"
  tags = {
    Name = "eip_${var.vpc_public_subnet_names[count.index]}"
  }

}


#tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
module "network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "> 5.8.0"

  name                 = "${var.vpc_name}-${var.client_name}"
  cidr                 = var.vpc_cidr
  enable_dns_hostnames = true

  azs                 = var.vpc_azs
  public_subnets      = var.vpc_public_subnets
  public_subnet_names = var.vpc_public_subnet_names

  private_subnets      = var.vpc_private_subnets
  private_subnet_names = var.vpc_private_subnet_names

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  reuse_nat_ips       = true
  external_nat_ip_ids = aws_eip.nat[*].id
  #
}
