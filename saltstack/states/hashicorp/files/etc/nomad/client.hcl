# /etc/nomad.d/client.hcl
datacenter = "dc1"
data_dir   = "/etc/nomad/"

client {
  enabled = true
  node_class = "node"
}