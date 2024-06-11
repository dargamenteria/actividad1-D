#data "aws_ami" "ami" {
#
#  most_recent = true
#
#  dynamic "filter" {
#    for_each = var.ec2_ami_filter
#    content {
#      name   = filter.value["name"]
#      values = filter.value["values"]
#    }
#  }
#
#  owners = var.ec2_ami_filter_owner
#}
#

module "ec2_instances" {

  source = "terraform-aws-modules/ec2-instance/aws"

  for_each      = { for k, v in var.ec2_instances : k => v if v.enabled == true } #only enabled ones
  name          = each.key
  ami           = each.value.ec2_ami #!= "" ? each.value.ec2_ami : data.aws_ami.ami.id #use latest ami if no amiid is defined
  instance_type = each.value.ec2_instance_type

  associate_public_ip_address = each.value.ec2_public_ip == true ? true : false # get public ip or not
  root_block_device           = each.value.ec2_root_block_device
  #vpc_security_group_ids =  [local.sg_map[each.value.ec2_sg]]
  vpc_security_group_ids = [for sg in each.value.ec2_sgs : aws_security_group.sgs[sg].id]
  #key_name = resource.aws_key_pair.kp.key_name
  key_name = "vockey"
  #subnets are public or private 
  subnet_id = each.value.ec2_snet == "public" ? module.network.public_subnets[each.value.ec2_snet_index] : module.network.private_subnets[each.value.ec2_snet_index]

  iam_instance_profile = each.value.profile
  user_data            = file("./resources/scripts/web_instance.sh")
  # metadata_options = var.ec2_metadata_options
  tags = merge(var.provider_default_tags, each.value.ec2_tags)
}


