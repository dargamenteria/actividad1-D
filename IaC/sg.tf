#resource "aws_default_security_group" "default" {
#  vpc_id = module.network.vpc_id
#  name = "default"
#}


resource "aws_security_group" "sgs" {
  for_each    = { for k, v in var.sgs : k => v if v.enabled == true } #only enabled ones
  vpc_id      = module.network.vpc_id
  name        = each.key
  tags        = each.value.sgs_tags
  description = each.value.description

}


resource "aws_security_group_rule" "sgs" {
  for_each = { for rule in var.sgs_rules : join("-", [rule.sg, sha1("${rule.sg}${rule.to}${rule.from}${rule.cidr}${rule.source_sg}${rule.description}")]) => rule }

  security_group_id = aws_security_group.sgs[each.value.sg].id
  from_port         = each.value.from
  to_port           = each.value.to
  type              = each.value.ingress == true ? "ingress" : "egress"
  protocol          = each.value.protocol
  description       = each.value.description

  cidr_blocks              = each.value.cidr != "" ? strcontains(each.value.cidr, "/") ? [each.value.cidr] : ["${local.ip_map[each.value.cidr]}/32"] : null
  ipv6_cidr_blocks         = each.value.ipv6_cidr != "" ? [each.value.ipv6_cidr] : null
  source_security_group_id = each.value.source_sg != "" ? aws_security_group.sgs[each.value.source_sg].id : null

}
