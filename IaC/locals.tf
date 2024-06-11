locals {

  #account_map = yamldecode(file("${path.module}/resources/accounts.yaml"))
  ip_map = yamldecode(file("${path.module}/resources/ips.yaml"))

}
