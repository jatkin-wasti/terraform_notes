# Terraform
- Is a HashiCorp product
- Uses ingress and egress rules as inbound and outbound rules
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
![Terraform](images/terraform_diagram.png)
## Difference between Ansible and Terraform
- Ansible: Better at Configuration management (provisioning)
- Terraform: Better at Orchestration management (networking)
## Syntax
- Language used is HCL similar to JSON in terms of syntax
- The file is made up of blocks e.g. resource, provider, variable etc., and
arguments e.g. instance_type = "t2.micro"
- The names of the arguments are important for the interpreter to understand and
run the file correctly
- General syntax is
```
block_type "name_of_block" {
  specific_argument = "appropriate value"
}
```
- The "name_of_block" can be anything that you want, but as stated above, the
block_type must be something that it will recognise
### Using system variables
- We may wish to obfuscate sensitive information in the terraform file, as we
don't want information such as AWS keys going on GitHub for everyone to see
- Therefore, we can create system variables on our machine to store this data (
  either through bashrc, or adding an environment variable in Windows)
- It will automatically look for your AWS keys and can see your environment
variables, so as long as they are named correctly and the credentials are
correct it should work
