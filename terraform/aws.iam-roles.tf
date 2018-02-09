# Create a role to allow our instances (Consul) to reference tagging on retry-join
# https://www.consul.io/docs/agent/options.html?#retry_join_ec2

resource "aws_iam_role" "nomad_iam_role" {
  name               = "${var.name_prefix}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Attach RO policy to our role
resource "aws_iam_role_policy_attachment" "policy_attachment_AWSReadOnly" {
  role        = "${aws_iam_role.nomad_iam_role.name}"
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

# Attach instance role to our instance.
resource "aws_iam_instance_profile" "nomad_iam_instance_role" {
  name = "${var.name_prefix}-InstanceRole"
  role = "${aws_iam_role.nomad_iam_role.name}"
}