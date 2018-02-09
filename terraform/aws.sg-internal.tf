resource "aws_security_group" "intercluster_coms" {
  name    = "${var.name_prefix} Internal"
  vpc_id  = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "${var.name_prefix} Internal",
  }
}

resource "aws_security_group_rule" "ingr_4646_nomad_api" {
  type            = "ingress"
  from_port       = 4646
  to_port         = 4646
  protocol        = "tcp"
  description     = "4646 - Nomad API port"
  source_security_group_id  = "${aws_security_group.intercluster_coms.id}"
  security_group_id         = "${aws_security_group.intercluster_coms.id}"
  depends_on  = ["aws_security_group.intercluster_coms"]
}
resource "aws_security_group_rule" "ingr_4647_nomad_client" {
  type            = "ingress"
  from_port       = 4647
  to_port         = 4647
  protocol        = "tcp"
  description     = "4647 - Nomad client port"
  source_security_group_id  = "${aws_security_group.intercluster_coms.id}"
  security_group_id         = "${aws_security_group.intercluster_coms.id}"
  depends_on  = ["aws_security_group.intercluster_coms"]
}
resource "aws_security_group_rule" "ingr_8301_tcp_consul" {
  type            = "ingress"
  from_port       = 8301
  to_port         = 8301
  protocol        = "tcp"
  description     = "8301 - Consul comm port TCP"
  source_security_group_id  = "${aws_security_group.intercluster_coms.id}"
  security_group_id         = "${aws_security_group.intercluster_coms.id}"
  depends_on  = ["aws_security_group.intercluster_coms"]
}
resource "aws_security_group_rule" "ingr_8301_udp_consul" {
  type            = "ingress"
  from_port       = 8301
  to_port         = 8301
  protocol        = "udp"
  description     = "8301 - Consul comm port UDP"
  source_security_group_id  = "${aws_security_group.intercluster_coms.id}"
  security_group_id         = "${aws_security_group.intercluster_coms.id}"
  depends_on  = ["aws_security_group.intercluster_coms"]
}