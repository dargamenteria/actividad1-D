variable "provider_default_tags" {
  description = "provider_default_tags"
  type        = map(any)
}

variable "client_name" {
  description = "client_name"
  type        = string
}

variable "region" {
  description = "region"
  type        = string
}

variable "vpc_name" {
  description = "vpc_name"
  type        = string
}

variable "vpc_cidr" {
  description = "vpc_cidr"
  type        = string
}

variable "vpc_public_subnets" {
  description = "vpc_public_subnets"
  type        = list(string)
}

variable "vpc_public_subnet_names" {
  description = "vpc_public_subnets"
  type        = list(string)
}

variable "vpc_private_subnets" {
  description = "vpc_private_subnets"
  type        = list(string)
}

variable "vpc_private_subnet_names" {
  description = "vpc_private_subnets"
  type        = list(string)
}
variable "vpc_azs" {
  description = "vpc_azs"
  type        = list(string)
}


variable "sgs" {
  description = "security groups going pot"
  type = map(object({
    enabled     = bool
    description = string
    sgs_tags    = map(any)
  }))
}

variable "sgs_rules" {
  description = "security inbound rules cidr"
  type = list(object({
    sg          = string
    from        = number
    to          = number
    ingress     = bool
    protocol    = string
    cidr        = string
    ipv6_cidr   = string
    source_sg   = string
    description = string
  }))
}

# variable "ec2_metadata_options" {
#   type = map(string)
# }
#
variable "ec2_instances" {
  description = "instances"
  type = map(object({
    enabled           = bool
    ec2_ami           = string
    ec2_instance_type = string
    ec2_ebs_encrypted = bool
    ec2_snet          = string
    ec2_snet_index    = number
    ec2_public_ip     = bool
    ec2_static_ip     = bool
    profile           = string
    ec2_sgs           = list(string)
    ec2_root_block_device = list(object({
      encrypted   = bool
      volume_type = string
      volume_size = number
    }))
    ec2_tags = map(any)
  }))
}

#variable "ec2_ami_filter" {
#  description = "Filter for amis"
#  type = list(object({
#    name   = string
#    values = list(string)
#  }))
#}
#variable "ec2_ami_filter_owner" {
#  type = list(string)
#}
#




