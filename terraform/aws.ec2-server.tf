resource "aws_instance" "nomad-server" {
  count           = 1
  ami             = "${var.ec2_base_ami}"
  instance_type   = "t2.micro"
  subnet_id       = "${var.ec2_subnet}"

  vpc_security_group_ids  = ["${split(",",var.ec2_sg)}", "${aws_security_group.intercluster_coms.id}"]
  user_data               = "${data.template_cloudinit_config.nomad_config.rendered}"
  key_name                = "${var.ec2_key_name}"

  tags {
    salt-role   = "control.nomad.server"
    Name        = "${var.name_prefix} - Server"
    cost        = "infra"
  }
}