---
base:
  'ec2_info:Tags:salt-role:control.nomad.*':
    - match: grain
    - hashicorp.consul