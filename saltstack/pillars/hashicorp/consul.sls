---
{% set bind_addr = salt['grains.get']('ec2_info:PrivateIpAddress', '127.0.0.1') %}
{% set node_name = salt['grains.get']('id', 'client') %}

consul:
  config:
    server:
      bootstrap_expect: 1
      server: true
      data_dir: /etc/consul
      log_level: INFO
      datacenter: aws-us-east-1
      bind_addr: {{ bind_addr }}
      node_name: {{ node_name }}
    client:
      server: false
      data_dir: /etc/consul
      log_level: INFO
      datacenter: aws-us-east-1
      bind_addr: {{ bind_addr }}
      node_name: {{ node_name }}
      retry_join:
        - "provider=aws tag_key=salt-role tag_value=control.nomad.server"
  services:
    nomad:
      service:
        name: nomad
        tags:
          - "nomad"
          - "nomad-server"
        port: 4647