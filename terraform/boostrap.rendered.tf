data "template_file" "nomad_bootstrap" {
  template  = "${file("./bootstrap.tpl")}"
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