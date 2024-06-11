provider_default_tags = {
  environment = "unir"
  terraform   = "true"
}

region = "us-east-1"

client_name = "unir"


vpc_name = "vpc"
vpc_cidr = "10.153.0.0/16"
vpc_azs  = ["us-east-1a"]

vpc_public_subnets      = ["10.153.10.0/24"]
vpc_public_subnet_names = ["pub_snet_a"]

vpc_private_subnets      = ["10.153.30.0/24"]
vpc_private_subnet_names = ["priv_snet_a"]



sgs = {
  sg1 = {
    enabled     = true
    description = "SG for the massess"
    sgs_tags = {
      Name = "sg1"
    }
  }
}

sgs_rules = [

  ##INGRESS RULES
  {
    sg = "sg1", from = 22, to = 22, ingress = true, protocol = "tcp", cidr = "0.0.0.0/0", ipv6_cidr = "", source_sg = "", description = "Allow ssh  [tf]"
  },
  {
    sg = "sg1", from = 8080, to = 8080, ingress = true, protocol = "tcp", cidr = "0.0.0.0/0", ipv6_cidr = "", source_sg = "", description = "Allow 8080 [tf]"
  },
  {
    sg = "sg1", from = 80, to = 80, ingress = true, protocol = "tcp", cidr = "0.0.0.0/0", ipv6_cidr = "", source_sg = "", description = "Allow http [tf]"
  },


  ## EGREES RULES
  {
    sg          = "sg1", from = 0, to = 0, ingress = false, protocol = "-1", cidr = "0.0.0.0/0", ipv6_cidr = "", source_sg = ""
    description = "Default egress rule [tf]"
  }

]


#ec2_ami_filter_owner = ["099720109477"] # Canonical

ec2_instances = {
  cloud9 = {
    enabled           = true
    ec2_ami           = "ami-00317f1b8715ed134"
    ec2_instance_type = "t3.medium"
    ec2_ebs_encrypted = true
    ec2_snet          = "public"
    ec2_public_ip     = true
    ec2_static_ip     = true
    ec2_snet_index    = 0
    ec2_sgs           = ["sg1"]
    profile           = "LabInstanceProfile"
    ec2_root_block_device = [{
      encrypted   = true
      volume_type = "gp2"
      volume_size = 20
    }]
    ec2_tags = {
      scheduled = "workdays"
    }
  }
}

