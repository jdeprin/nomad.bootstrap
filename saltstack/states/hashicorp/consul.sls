---
{% set agent = salt['grains.get']('ec2_info:Tags:salt-role', 'control.nomad.client') %}

/etc/consul/consul.d:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

{% if agent == 'control.nomad.server' %}
/etc/consul/server.json:
  file.serialize:
    - user: root
    - group: root
    - mode: 644
    - dataset_pillar: "consul:config:server"
    - formatter: json

/etc/consul/consul.d/nomad.json:
  file.serialize:
    - user: root
    - group: root
    - mode: 644
    - dataset_pillar: "consul:services:nomad"
    - formatter: json

/etc/rc.d/init.d/consul-server:
  file.managed:
    - source: salt://hashicorp/files/etc/init.d/consul-server
    - user: root
    - group: root
    - mode: 644

consul-server-service:
  service.running:
    - name: consul-server
    - enable: True
    - require:
      - file: /etc/rc.d/init.d/consul-server
{% endif %}

{% if agent == 'control.nomad.client' %}
/etc/consul/client.json:
  file.serialize:
    - user: root
    - group: root
    - mode: 644
    - dataset_pillar: "consul:config:client"
    - formatter: json

/etc/rc.d/init.d/consul-client:
  file.managed:
    - source: salt://hashicorp/files/etc/init.d/consul-client
    - user: root
    - group: root
    - mode: 644

consul-client-service:
  service.running:
    - name: consul-client
    - enable: True
    - require:
      - file: /etc/rc.d/init.d/consul-client
{% endif %}