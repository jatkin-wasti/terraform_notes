# Terraform
- Terraform Is a HashiCorp product (the same company that makes Packer and Vagrant)
- It's an IAC orchestration tool - it allows you to create IAC for
deployment on any cloud, which means it's cloud independent
- Cloud independent: Gives flexibility to be able to use different software or
cloud provider (e.g. Azure, AWS etc) by changing one or two lines, while keeping
 the rest of the code the same
- This is especially important as the industry is moving towards multi cloud
infrastructure (using multiple cloud providers to have the same infrastructure
  on multiple providers to decrease the chance and cost of downtime)
    - This functions similarly to a disaster recovery plan
    - If one provider goes down, the traffic can be diverted to the other provider
- Increases efficiency by automating the setup on AWS
- Uses ingress and egress rules as inbound and outbound rules
- Lets you scale up and down as needed
![Terraform](images/terraform_diagram.png)
## Difference between Ansible and Terraform
- Ansible: Better at Configuration management (provisioning)
- Terraform: Better at Orchestration management (networking)
## Installation
- [Download](https://www.terraform.io/downloads.html) the correct Zip file for your OS
- Extract the application file and either move it to a location in your OS's PATH
or add the desired location to the OS PATH
- For Windows you can simply move the file to the Windows or Program Files folder
## Syntax
### General Syntax
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
- You have to specify which provider you are using with a provider block e.g.
```
provider "aws" {
         region = "eu-west-1"
}
```
- An example of a resource block creating an EC2 instance from an existing AMI
can be found below
```
resource "aws_instance" "desired_name"{
        ami = "ami-id"
        instance_type = "processor_type"
        associate_public_ip_address = true
        tags = {
            Name = "desired_instance_name"
        }
        key_name = "aws_key_here"
}
```
### Creating Security Groups
- We can also create Security Groups with terraform using ingress and egress rules
- A simple example below shows a template for creating a security group that allows
SSH access to your own IP
- As in the above examples, the placeholder values will need to be changed e.g.
your IP should replace `your.ip.goes.here` and the vpc id should replace `vpc-id`
```
resource "aws_security_group" "appropriate-name" {
  name        = "appropriate-name"
  description = "fitting description here"
  vpc_id      = "vpc-id"

  ingress {
    description = "fitting description here"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["your.ip.goes.here/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "name-of-SG"
  }
}

```
### Using terraform variables
- Certain parts of our terraform files might change a lot, so instead of having
to manually change each occurrence every time we can use variables instead
- We can create a variables.tf file and add resource blocks defining our variables
- A generic variable block could look like this
```
variable "variable_name" {
    type = data_type
    default = default_value
}
```
- You can declare all kinds of data types and set default values to be used
- Once we've created these variables we can replace some of the hardcoded arguments
- To do this we simply replace the argument's ``"hardcoded_value"`` with `var.variable_name`
 where variable_name is your variable name
 - So, say we define a string variable for our providers region, as below
 ```
 variable "region" {
     type = string
     default = "eu-west-1"
 }
 ```
 - We can then change the argument's value in the provider block from earlier to become
 ```
 provider "aws" {
          region = var.region
 }
 ```
### Using dynamic referencing of resource parameters
- We might need to reference the ID or other infrastructure values that haven't
been created yet
- Terraform allows us to do this dynamically using the resource, it's name and
the parameter we want
### Using system variables
- We may wish to obfuscate sensitive information in the terraform file, as we
don't want information such as AWS keys going on GitHub for everyone to see
- Therefore, we can create system variables on our machine to store this data (
  either through bashrc, or adding an environment variable in Windows)
- It will automatically look for your AWS keys and can see your environment
variables, so as long as they are named correctly and the credentials are
correct it should work
## Using modules
- By default, all our .tf files are in the root module
- We can logically split large blocks of functionality into their own files
within a module to abstract complexity
- These new modules can be called from our root module and are referred to as
child modules
- We can also make use of modules that other people have made
- To call a child module, the syntax is
```
module "local_name_for_module" {
  source = "./source/of/module"
  version = " < 0.7.5, > 0.5.0"
}
```
- In the above example, we:
  - Specify a name for the module so that we can refer to it later
  - Specify which module to load and from where with source
  - Specify which version of the module to use if it is a published module (if
    multiple versions that satisfies the constraint are found, it will download
    the newest of these versions)
- A child module only has access to data in that module, and likewise parent
modules can not access the child processes data either
- When creating a resource in a module that may require another resource's
information, we can specify this with `depends on` as seen below, though this
should be done sparingly
```
depends on = [
  resource_type.name_of_resource
]
```
- For a parent module to access information from a child module, we can use
output values as seen below
```
resource "resource_type" "name_of_resource" {
  logical_name = module.module_name.attribute
}
```
- Or we can create an output.tf file to retrieve this information
- This file will have output blocks as seen below
```
output sg_app_id {
    description = "id of app security group"
    value = aws_security_group.sg_app.id
}
```
- For a child module to access information from a parent module, we can pass it
in like this
```
module "local_name_for_module" {
  variable_name = resource_type.resource_name.attribute
  variable_name2 = var.variable_name
}
```
## Load Balancing
### What is Load Balancing
- Load Balancing is the act of distributing work across multiple computing
resources for smoother operations
- This could take the form of distributing application traffic to multiple EC2's
across different Availability Zones
- The resource block for an aws load balancer will look something like the
example below
```
resource "aws_lb" "load_balancer_name" {
  arguments = "example"
}
```
### What types of Load Balancing are there?
#### Static algorithms
- Doesn't take into account the state of a system when distributing work
- Assumptions of the system are used with the information it does know e.g. number
  and power of available processors
- Usually centralised around a router that distributes the tasks to optimise
performance
- Easy to set up
- Very efficient for regular tasks
- Can lead to overloading of some computer resources
#### Dynamic algorithms
- Takes into account the current workload of the computer resources
- If a computer resource is overloading, some of it's work can be diverted to
another available resource
- Complicated to design but produces great results
- Architecture can be more modular
## Auto Scaling
- Helps maintain a desired number of instances which can be crucial to ensure
good load balancing
- Can specify a minimum or maximum number of instances to exist at any one time
- Can specify an exact number of instances at any given time
- Based on traffic or demand, you can scale up the number of instances (or down
  for drops in traffic)
- This is all done automatically once the scaling policies have been set
### Auto Scaling Groups
- Collection of EC2's that are linked to facilitate auto scaling
- Health checks are periodically run on the group to see if there are any issues
with the instances within the auto scaling group
  - If an issue is found, the instance is marked as unhealthily and may be
  terminated and replaced with a new healthy instance
- The auto scaling group ensures that the number of live instances matches the
desired capacity and if the current infrastructure should be up or down scaled
- A high availability system is one where important architecture is stored
in multiple places to greatly decrease the chance of system failure
  - Although it may seem unintuitive to pay to store the same data many times
   over, this will often pay for itself over time i.e. if your system is down
   once a year for half an hour and that costs you £3m in potential profit, and
   the backups cost £6m a year, having these backups will give a return on
   investment after 2 years
## Terraform commands
**terraform help**
- This will show you a list of commands that you can use with terraform

**terraform init**
- This will initialise the current directory as a terraform environment

**terraform validate**
- This will check the terraform files for any errors and notify us of where these
errors occurred
- It is useful to run this after making changes to make sure you haven't made
a syntax error

**terraform plan**
- This will show the changes that the current build will enact

**terraform build**
- This will execute the code in your terraform files

**terraform destroy**
- This will destroy the created infrastructure
