Terraform module to provision an EC2 instance that is running Apache.

Not intended for production use. It is just showcasing how to create a custom public module on Terraform registry.

```hcl
terraform {
  
}

provider "aws" {
  region = "us-east-1"
  alias = "east"
}

module "apache" {
  source = ".//terraform_aws_apache-example"
  vpc_id = "vpc-000000000"
  my_ip_with_cidr = "MY_OWN_IP_ADDRESS/32"
  public_key = "ssh-rsa AAAAB..."
  instance_type = "t2.micro"
  server_name = "Apache Example Server"
  server_owner = "MY_NAME"
}
```