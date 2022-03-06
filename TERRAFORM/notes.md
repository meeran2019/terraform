---------------------------------------------------------------------------------------------------------
TERRAFORM:
---------------------------------------------------------------------------------------------------------

    It is Infrastructure as Code (IaC). 
    Automation of infrastructure. 
    Keep infrastructure in certain state. 
    It makes infrastructure auditable. Store the code in version control system. 
    It works well with automation tools like ansible tools.

---------------------------------------------------------------------------------------------------------
INSTALLATION: 
---------------------------------------------------------------------------------------------------------

    To refer the terraform documentation. 

---------------------------------------------------------------------------------------------------------
TERRAFORM HCL (HASHICORP CONFIGURATION LANGUAGE):
---------------------------------------------------------------------------------------------------------

    Variables can be referenced by, 
        1. using var.variable-name 
        2. using "${var.variable-name}"

---------------------------------------------------------------------------------------------------------
AWS AUTHENTICATIONS: 
---------------------------------------------------------------------------------------------------------

AWS Provides different authentications, 

    Static credentials: 
            Hard coding values for access_key and secret_key inline in aws provider block. 

    Environment variables: 
            Provide credentials via the environment variables of AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY. 

    Shared credentials file: 
            Default AWS credential file is stored in $HOME/.aws/credentials.
            Custom location can be given by using shared_credentials_file variable. 
            
    Role: 
            Role ARN will be used to assume the role using assume_role. 

---------------------------------------------------------------------------------------------------------
VARIABLE TYPES: 
---------------------------------------------------------------------------------------------------------

    Simple variable types: 
        String 
        Number 
        Boolean 

    Complex variable types: 
        List(Type): 
                [1,2,3] /  ["a","b"]
                It is ordered. 

        set(type): 
                {1,2,3}
                It contains unique value. 

        map (type): 
                { key1: "value1", key2: "value2"}
                It has key value pair. 
        Tuple: 
                It is like list but each element can be different type.
                [0, "string", boolean]
    
    # If type is not mentioned, based on the value, terraform takes the type. 

    variable "variable-name" {
        default = "sample value"
    }

    variable "variable-name" {
        type = string
        default = "sample value"
    }
    
---------------------------------------------------------------------------------------------------------
SOFTWARE PROVISIONING: 
---------------------------------------------------------------------------------------------------------

There are 2 ways to provision software on server machine, 
    1. Use own cusom AMI with bundled software package in image. Packer is used. 
    2. Boot standard AMI and then install software on it, 
            Using file uploads 
            Using remote exec 
            Using automation tools like chef, puppet, ansible. 
    
    File Uploads: 
        It is easy way to upload a file or script. 
        Can be used in conjuction with remote-exec to execute a script. 
        Provisoner may be SSH or WinRM which uses connection. 

        provisioner "file"{
            source = "app.conf"
            destination = "/etc/myapp.conf"
        }
        
        provisioner "file"{
            source = "app.conf"
            destination = "/etc/myapp.conf"
            connection{
                user=
                password=
            }
        }

        provider "remote-exec"{
            inline = ["chmod +x /opt/script.sh", "./script.sh"]
        }

Provisioner - File: 
        To copy the file from running machine to the newly created machine. 

Provisioner - local-exec: 
        Invokes a local executable after resource is created in terraform machine. 

Provisioner - remote-exec: 
        Invoke a resource in remote resource after it is created. 
        It requires connection and support both ssh and winrm. 
        It supports the following arguments, 
            inline - ["command1","command2"]
            script - Path to local script which copied to remote resource and executed. 
            scripts - Path to local script which copied to remote resource and executed. They are executed in order they are provided.
            
---------------------------------------------------------------------------------------------------------
OUTPUT: 
---------------------------------------------------------------------------------------------------------
    Can use attributes in a script. 

    output "name" {
        value = resource-type.resource-name.attribute-name
    }

    provisioner "local-exec" {
        command = "echo resource-type.resource-name.attribute-name  >> attribute.txt"
    }

---------------------------------------------------------------------------------------------------------
REMOTE STATE: 
---------------------------------------------------------------------------------------------------------

    Terraform store its remote inftrastructure in terraform.tfstate file. 
    .tfstate file can be stored in version control. 
    It helps to collaborate in team.

    backend functionality is used to store the tfstate file: 
        local - default backend 
        remote - save in remote like terraform cloud. It doesnot support locking. 
        s3 (locking using dynamodb )
        consul (locking)

        # Using a single workspace:
        terraform {
          backend "remote" {
            hostname = "app.terraform.io"
            organization = "company"
        
            workspaces {
              name = "my-app-prod"
            }
          }
        }
        
        # Using multiple workspaces:
        terraform {
          backend "remote" {
            hostname = "app.terraform.io"
            organization = "company"

---------------------------------------------------------------------------------------------------------
DATA SOURCE: 
---------------------------------------------------------------------------------------------------------

    It allow terraform to use information defined outside of terraform. 
    It provides dynamic information. 

    data "aws_ami" "example" {
        most_recent = true
      
        owners = ["self"]
        tags = {
          Name   = "app-server"
          Tested = "true"
        }
      }

    data.aws_ami.example.id 

---------------------------------------------------------------------------------------------------------
TEMPLATES: 
---------------------------------------------------------------------------------------------------------

    It helps to creating customized configuration file. 
    Can build templates based on the file. 
    Can be used to generate generic template or cloud init config. 
    If want to pass user data based on other configuration, can use template. 

    data "template_file" "init" {
    template = "${file("${path.module}/init.tpl")}"
    vars = {
        consul_address = "${aws_instance.consul.private_ip}"
    }
    }

    init.tpl 
    #!/bin/bash
    echo "CONSUL_ADDRESS = ${consul_address}" > /tmp/iplist

---------------------------------------------------------------------------------------------------------
TEMPLATES IN TERRAFORM 0.12: 
---------------------------------------------------------------------------------------------------------
    templatefile reads the file at given path and render its content as content using supplied set of tempalte variables. 

    templatefile(path, variables in map)

---------------------------------------------------------------------------------------------------------
OTHER PROVIDERS: 
---------------------------------------------------------------------------------------------------------

    Terraform has many providers to choose from, 
        AWS 
        API 
        Azure 
        Google 
        VMware 
        Datadog 
        Github 

---------------------------------------------------------------------------------------------------------
MODULES: 
---------------------------------------------------------------------------------------------------------

    Use modules to make terraform more organized. 
    reuse the code. 
    use third party modules.
    use a module from github. 
    use a module from local folder. 

    can pass arguments to the model. 

---------------------------------------------------------------------------------------------------------
TERRAFORM COMMANDS: 
---------------------------------------------------------------------------------------------------------

terraform apply 
terraform destroy 
terraform validate 
terraform fmt 
terraform graph 
terraform import address-id     -   import to tfstate file not .tf file.
terraform output 
terraform plan 
terraform refresh               -   refresh remote state
terraform show                  -   show state file in readable
terraform state                 -   for state management
terraform taint                 -   during next apply, destroy and create it 
terraform untaint               -   remove taint 

---------------------------------------------------------------------------------------------------------

