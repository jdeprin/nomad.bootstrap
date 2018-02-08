provider "aws" {
  region = "us-east-1"
  profile = "ebsdev"
}

variable "vpc_id" {
  type = "string"
  default = "vpc-34ce3351"
}

data "template_file" "nomad_bootstrap" {
  template = "${file("./bootstrap.tpl")}"
}
data "template_cloudinit_config" "nomad_config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "bootstrap.sh"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.nomad_bootstrap.rendered}"
  }
}

resource "aws_security_group" "intercluster_coms" {
  name = "nomad POC Internal"
  vpc_id = "${var.vpc_id}"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags = {
    Name = "nomad POC Internal",
  }
}

resource "aws_security_group_rule" "ingr_4646_nomad_api" {
  type            = "ingress"
  from_port       = 4646
  to_port         = 4646
  protocol        = "tcp"
  description     = "4646 - Nomad API port"
  source_security_group_id = "${aws_security_group.intercluster_coms.id}"
  security_group_id   = "${aws_security_group.intercluster_coms.id}"
  depends_on = ["aws_security_group.intercluster_coms"]
}
resource "aws_security_group_rule" "ingr_8301_tcp_consul" {
  type            = "ingress"
  from_port       = 8301
  to_port         = 8301
  protocol        = "tcp"
  description     = "8301 - Consul port"
  source_security_group_id = "${aws_security_group.intercluster_coms.id}"
  security_group_id   = "${aws_security_group.intercluster_coms.id}"
  depends_on = ["aws_security_group.intercluster_coms"]
}
resource "aws_security_group_rule" "ingr_8301_udp_consul" {
  type            = "ingress"
  from_port       = 8301
  to_port         = 8301
  protocol        = "udp"
  description     = "8301 - Consul port"
  source_security_group_id = "${aws_security_group.intercluster_coms.id}"
  security_group_id   = "${aws_security_group.intercluster_coms.id}"
  depends_on = ["aws_security_group.intercluster_coms"]
}



resource "aws_instance" "nomad-master" {
  ami = "ami-df809ca4"
  instance_type = "t2.micro"
  subnet_id = "subnet-9992a5df"

  vpc_security_group_ids = ["sg-e15c2c85", "sg-872b6cf2", "${aws_security_group.intercluster_coms.id}"]
  user_data           = "${data.template_cloudinit_config.nomad_config.rendered}"
  key_name            = "TG-Non-Prod-Admin"

  tags {
    salt-role = "control.nomad.master"
    Name = "Nomad POC - Master"
    cost = "infra"
  }
}
resource "aws_instance" "nomad-client" {
  count = 1
  ami = "ami-df809ca4"
  instance_type = "t2.micro"
  subnet_id = "subnet-9992a5df"

  vpc_security_group_ids = ["sg-e15c2c85", "sg-872b6cf2", "${aws_security_group.intercluster_coms.id}"]
  user_data           = "${data.template_cloudinit_config.nomad_config.rendered}"
  key_name            = "TG-Non-Prod-Admin"

  tags {
    salt-role = "control.nomad.client"
    Name = "Nomad POC - Client"
    cost = "infra"
  }
}