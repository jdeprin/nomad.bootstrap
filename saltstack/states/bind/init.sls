---
bind-instal:
  pkg.installed:
    - names:
      - bind
      - bind-utils

named:
  service.running:
    - enable: True
    - require:
      - pkg: bind
      - pkg: bind-utils
      - file: /etc/named.conf
      - file: /etc/named/consul.conf
    - watch:
      - file: /etc/named.conf
      - file: /etc/named/consul.conf

/etc/named.conf:
  file.managed:
    - source: salt://bind/files/etc/named.conf
    - user: root
    - group: root
    - mode: 640
    - require:
      - pkg: bind

/etc/named/consul.conf:
  file.managed:
    - source: salt://bind/files/etc/named/consul.conf
    - user: root
    - group: root
    - mode: 640
    - require:
      - pkg: bind