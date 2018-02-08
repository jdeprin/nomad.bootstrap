---
{% set agent = salt['grains.get']('ec2_info:Tags:salt-role', 'control.nomad.client') %}

docker:
  pkg.installed:
    - name: docker

docker-service:
  service.running:
    - name: docker
    - enable: True
    - watch:
      - pkg: docker

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

{% if agent == 'control.nomad.master' %}
/etc/nomad/server.hcl:
  file.managed:
    - source: salt://hashicorp/files/etc/nomad/server.hcl
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /etc/nomad/nomad.d

/etc/rc.d/init.d/nomad-server:
  file.managed:
    - source: salt://hashicorp/files/etc/init.d/nomad-server
    - user: root
    - group: root
    - mode: 755
{% endif %}

{% if agent == 'control.nomad.client' %}
/etc/nomad/server.hcl:
  file.managed:
    - source: salt://hashicorp/files/etc/nomad/client.hcl
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /etc/nomad/nomad.d

/etc/rc.d/init.d/nomad-server:
  file.managed:
    - source: salt://hashicorp/files/etc/init.d/nomad-client
    - user: root
    - group: root
    - mode: 755
{% endif %}