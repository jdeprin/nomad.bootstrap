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

{% if agent == 'control.nomad.master' %}
/etc/consul/server.json:
  file.serialize:
    - user: root
    - group: root
    - mode: 644
    - dataset_pillar: "consul:config:server"
    - formatter: json

/etc/consul/consul.d/web.json:
  file.managed:
    - source: salt://hashicorp/files/etc/consul/consul.d/web.json
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /etc/consul/consul.d

/etc/rc.d/init.d/consul-server:
  file.managed:
    - source: salt://hashicorp/files/etc/init.d/consul-server
    - user: root
    - group: root
    - mode: 755
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
    - mode: 755
{% endif %}