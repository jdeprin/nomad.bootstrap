---
{% set agent = salt['grains.get']('ec2_info:Tags:salt-role', 'control.nomad.client') %}

/etc/nomad/nomad.d:
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
/etc/nomad/server.json:
  file.serialize:
    - user: root
    - group: root
    - mode: 644
    - dataset_pillar: "nomad:config:server"
    - formatter: json

/etc/rc.d/init.d/nomad-server:
  file.managed:
    - source: salt://hashicorp/files/etc/init.d/nomad-server
    - user: root
    - group: root
    - mode: 644

nomad-server-service:
  service.running:
    - name: nomad-server
    - enable: True
    - require:
      - file: /etc/rc.d/init.d/nomad-server
{% endif %}

{% if agent == 'control.nomad.client' %}
/etc/nomad/client.json:
  file.serialize:
    - user: root
    - group: root
    - mode: 644
    - dataset_pillar: "nomad:config:client"
    - formatter: json

/etc/rc.d/init.d/nomad-client:
  file.managed:
    - source: salt://hashicorp/files/etc/init.d/nomad-client
    - user: root
    - group: root
    - mode: 644

nomad-client-service:
  service.running:
    - name: nomad-client
    - enable: True
    - require:
      - file: /etc/rc.d/init.d/nomad-client
{% endif %}