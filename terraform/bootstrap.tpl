#!/bin/bash

# Salt
cd /tmp; curl -L https://bootstrap.saltstack.com -o bootstrap_salt.sh
sh /tmp/bootstrap_salt.sh -X -A ${SALT_HOST}
echo "master_finger: '${SALT_FINGER}'" > /etc/salt/minion.d/97-master_finger.conf
echo "minion_id_caching: False" > /etc/salt/minion.d/98-minion_id_caching.conf
service salt-minion start

# Nomad
wget --directory-prefix=/tmp/nomad${NOMAD_VERSION}/ https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip
unzip /tmp/nomad${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip -d /tmp/nomad${NOMAD_VERSION}/
mkdir -p /usr/local/bin/nomad/versions/${NOMAD_VERSION}/
mv /tmp/nomad${NOMAD_VERSION}/nomad /usr/local/bin/nomad/versions/${NOMAD_VERSION}/nomad
ln -s /usr/local/bin/nomad/versions/${NOMAD_VERSION}/nomad /usr/bin/nomad${NOMAD_VERSION}
ln -s /usr/local/bin/nomad/versions/${NOMAD_VERSION}/nomad /usr/bin/nomad

# Consul
wget --directory-prefix=/tmp/consul${CONSUL_VERSION}/ https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
unzip /tmp/consul${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -d /tmp/consul${CONSUL_VERSION}/
mkdir -p /usr/local/bin/consul/versions/${CONSUL_VERSION}/
mv /tmp/consul${CONSUL_VERSION}/consul /usr/local/bin/consul/versions/${CONSUL_VERSION}/consul
ln -s /usr/local/bin/consul/versions/${CONSUL_VERSION}/consul /usr/bin/consul${CONSUL_VERSION}
ln -s /usr/local/bin/consul/versions/${CONSUL_VERSION}/consul /usr/bin/consul

# Clean up
rm -f /tmp/bootstrap_salt.sh
rm -f /tmp/nomad${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip
rm -f /tmp/consul${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip