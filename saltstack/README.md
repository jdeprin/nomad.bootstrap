# SaltStack

### States
Basic states for Consul, Nomad and Docker are included.  I've also added init scripts to enable you to start these items as a service.  In production it may be worth while to use something such as systemd in their place.  

My states use AWS tagging as salt grains to target the machines and their role.  This isn't required but a helpful demonstration of how one could transition this environment to production and be more scalable.

The Docker state is very bare bones and should be updated based on your needs.  I would recommend referencing the officially maintained state at https://github.com/saltstack-formulas/docker-formula

### Pillars
The pillar data here is used to build the Consul and Nomad configurations in JSON format.  I also include a service configuration for the nomad servers so that the clients can discover the masters through Consul