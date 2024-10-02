variable "instance_type" {
  description = "The type of EC2 instance to be launched, e.g., 't2.micro' for a small instance."
  type = string
  
}
variable "Name" {
  description = "The name to assign to the EC2 instance."
  type = string
}

variable "ami_id" {
  description = "The Amazon Machine Image (AMI) ID to use for the EC2 instance. For example, 'ami-0abcdef1234567890' for Amazon Linux 2023."
  type = string
   
}
variable "public_subnet_id" {
  description = "A list of IDs for the public subnets where the EC2 instance will be launched."
  type = list(string)
   
}
variable "private_subnet_id" {
  description = "A list of IDs for the private subnets where the EC2 instance will be launched, if applicable."
  type = list(string)
   
}

variable "ssh_port" {
  description = "The port number used for SSH connections to the EC2 instance. The default is set to 22."
  type = number
  default = 22
  
}
variable "HTTP_port" {
  description = "The port number used for HTTP traffic. The default is set to 80."
  type = number
  default = 80
}

variable "vpc_id" {
  description = "The ID of the Virtual Private Cloud (VPC) where the EC2 instance will be deployed."
  type = string
}

variable "load_balancer_dns" {
  description = "The DNS name of the load balancer that will route traffic to the EC2 instance."
  type = string
}
variable "key_Name" {
  description = "The name of the SSH key pair associated with the EC2 instance for secure access."
  type = string
}
# variable "public_ec2_user_data" {
#   type = list(string)
# }
# variable "private_ec2_user_data" {
#   type = list(string)
# }