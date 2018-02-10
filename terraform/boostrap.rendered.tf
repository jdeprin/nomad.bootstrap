data "template_file" "nomad_bootstrap" {
  template  = "${file("./bootstrap.tpl")}"

  vars {
    NOMAD_VERSION   = "0.7.1"
    CONSUL_VERSION  = "1.0.5"
    SALT_HOST       = "${var.salt_host}"
    SALT_FINGER     = "${var.salt_finger}"
  }
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