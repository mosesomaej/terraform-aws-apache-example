variable "vpc_id" {
  type = string
}

variable "my_ip_with_cidr" {
  type = string
  description = "Provide your IP e.g 198.53.169.216/32"
}

variable "public_key" {
  type = string
  description = "Provide your public key"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
  description = "Provide the instance type"
}

variable "server_name" {
  type = string
  default = "Apache Example Server"
}

variable "server_owner" {
  type = string
  default = "Mozees"
}