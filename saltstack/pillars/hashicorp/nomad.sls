---
{% set bind_addr = salt['grains.get']('ec2_info:PrivateIpAddress', '127.0.0.1') %}
{% set node_name = salt['grains.get']('id', 'client') %}

nomad:
  config:
    server:
      server:
        bootstrap_expect: 1
        enabled: true
      data_dir: /etc/nomad
      log_level: INFO
      datacenter: aws-us-east-1
      bind_addr: {{ bind_addr }}
      name: {{ node_name }}
    client:
      client:
        enabled: true
        servers:
          - nomad.service.consul
        node_class: node
      data_dir: /etc/nomad
      log_level: INFO
      datacenter: aws-us-east-1
      bind_addr: {{ bind_addr }}
      name: {{ node_name }}