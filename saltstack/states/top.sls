base:
  'ec2_info:Tags:salt-role:control.nomad.*':
    - match: grain
    - hashicorp.nomad
    - hashicorp.consul
    - docker