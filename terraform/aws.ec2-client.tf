resource "aws_instance" "nomad-client" {
  count           = 2
  ami             = "${var.ec2_base_ami}"
  instance_type   = "t2.micro"
  subnet_id       = "${var.ec2_subnet}"

  vpc_security_group_ids  = ["${split(",",var.ec2_base_sg)}", "${aws_security_group.intercluster_coms.id}"]
  user_data               = "${data.template_cloudinit_config.nomad_config.rendered}"
  key_name                = "${var.ec2_key_name}"
  iam_instance_profile    = "${aws_iam_instance_profile.nomad_iam_instance_role.name}"

  tags {
    salt-role   = "control.nomad.client"
    Name        = "${var.name_prefix} - Client"
    cost        = "infra"
  }
}