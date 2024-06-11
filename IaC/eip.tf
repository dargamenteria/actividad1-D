resource "aws_eip" "eips" {
  for_each = { for k, v in var.ec2_instances : k => v if v.enabled == true && v.ec2_static_ip == true } #only enabled ones with static_ip
  instance = module.ec2_instances[each.key].id
  domain   = "vpc"
  tags = {
    Name        = each.key
    Terraformed = true
  }
}
