#!/bin/bash
wget --directory-prefix=/tmp/nomad0.7.1/ https://releases.hashicorp.com/nomad/0.7.1/nomad_0.7.1_linux_amd64.zip
wget --directory-prefix=/tmp/consul1.0.3/ https://releases.hashicorp.com/consul/1.0.3/consul_1.0.3_linux_amd64.zip
unzip /tmp/nomad0.7.1/nomad_0.7.1_linux_amd64.zip -d /tmp/nomad0.7.1/
unzip /tmp/consul1.0.3/consul_1.0.3_linux_amd64.zip -d /tmp/consul1.0.3/
mkdir -p /usr/local/bin/nomad/versions/0.7.1/
mkdir -p /usr/local/bin/consul/versions/1.0.3/
mv /tmp/nomad0.7.1/nomad /usr/local/bin/nomad/versions/0.7.1/nomad
mv /tmp/consul1.0.3/consul /usr/local/bin/consul/versions/1.0.3/consul
ln -s /usr/local/bin/nomad/versions/0.7.1/nomad /usr/bin/nomad0.7.1
ln -s /usr/local/bin/nomad/versions/0.7.1/nomad /usr/bin/nomad
ln -s /usr/local/bin/consul/versions/1.0.3/consul /usr/bin/consul1.0.3
ln -s /usr/local/bin/consul/versions/1.0.3/consul /usr/bin/consul