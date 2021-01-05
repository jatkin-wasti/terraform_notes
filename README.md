# Terraform
- Is a HashiCorp product
- Uses egress rules as inbound and outbound rules
- Increases efficiency by automating the setup on AWS
- Terraform is an IAC orchestration tool - it allows you to create IAC for
deployment on any cloud
- Cloud independent: Gives flexibility to be able to use different software or
cloud provider (e.g. Azure, AWS etc) by changing one or two lines, while keeping
 the rest of the
  code the same
- Industry is moving towards multi cloud (using multiple cloud providers to
  have the same infrastructure on multiple providers to decrease the chance
  and cost of downtime), similar to a disaster recovery plan
  - If one provider goes down, the traffic can be diverted to the other provider
- Lets you scale up and down as needed
![Terraform](/images/terraform_diagram.png)
## Difference between Ansible and Terraform
- Ansible: Better at Configuration management (provisioning)
- Terraform: Better at Orchestration management (networking)
## Language used is HCL similar to JSON in terms of syntax
