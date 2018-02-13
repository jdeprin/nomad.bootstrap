# nomad.bootstrap
This is intended to be a quick guide to getting started with HashiCorp's Nomad and Consul services.  I provide a mostly plug and play solution that should be helpful for understanding the basics of both services.

This documentation will be updated with more details as I go forward.  Please stay tuned.

## Steps

### Build with Terraform
I've built a small environment using Terraform (https://www.terraform.io/).
  1. Populate a .tfvars file with variables specific to your account.  The AMI ID should be the most up to date Amazon Linux AMI.  You can move to another AMI if you wish however I only built the Salt States for RedHat based machines.  If you do not plan on using SaltStack you may want to include a security group to allow SSH access to the machines, I do not configure one as part of the build.
  2. Modify the [bootstrap.rendered.tf](../terraform/bootstrap.rendered.tf) file to use the most up to date versions of Consul and Nomad.
  3. If you do not plan on using SaltStack for configuration modify the [bootstrap.tpl](../terraform/bootstrap.tpl) file to remove the initial setup.
  4. Run a plan and apply using the tfvars file in the Terraform directory.

### Configure with SaltStack (or not)
I use SaltStack for installing and configuring the componants.  This isn't required although does make for a nice repeatable environment.  My SaltStack configuraitons use AWS tagging heavily in minion targeting.  You'll notice this in my [top.sls](../saltstack/top.sls) file.  You can always change this to target based in minion id.
 1. Run `salt-key -A` to accept your new minions
 2. Run `state.apply` to apply configurations
 
### Running Jobs
Your Nomad UI will be available at _nomad-servers IP_:4646/ui/ for viewing job details.  
From here you can follow the Jobs tutorial https://www.nomadproject.io/intro/getting-started/jobs.html or copy my included (sample-jobs)[../sample-jobs].  The sample jobs are built to showcase connecting Jobs together using Consul.

