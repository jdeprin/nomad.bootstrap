# Terraform documents

### Nomad & Consul Servers
These documents will build an environment with one master and two client servers.  Please reference the HashiCorp page for details on the number of recommended machines in production. https://www.consul.io/docs/internals/consensus.html#deployment_table

These machines will boot to the standard AWS Linux AMI.
 
### Security Groups
I include a security group for Nomad and Consul communication.  Any other ports (SSH for example) should be added as needed.

### Bootstrap
The binary for both Consul and Nomad are installed by default.  I also install the salt-minion client at this point to make configuration more manageable however I do not go into how to setup and configure a salt master.
