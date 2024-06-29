resource "tls_private_key" "pk" {
  algorithm = "RSA"
}

resource "aws_key_pair" "kp" {
  key_name   = "${var.client_name}_key"
  public_key = tls_private_key.pk.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "global_resources/${var.client_name}/${aws_key_pair.kp.key_name}.pem"
  file_permission ="600"
  content = tls_private_key.pk.private_key_pem
}
