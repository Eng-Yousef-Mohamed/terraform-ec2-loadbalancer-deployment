# Variables for the VPC module
variable "vpc_Name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets_cidr" {
  description = "The CIDR block for the public subnets"
  type = list(string)
}
variable "private_subnets_cidr" {
  description = "The CIDR block for the private subnets"
  type = list(string)
}
variable "availability_Zones_subnet" {
  description = "A list of availability zones for the subnets"
  type        = list(string)
}

variable "allow_nat_gateway" {
  description = "Flag to allow NAT Gateway"
  type        = bool
}

# Variables for the EC2 module
variable "ec2_Name" {
  description = "The name of the EC2 instance"
  type        = string
}


variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of the EC2 instance"
  type        = string
}

variable "key_Name" {
  description = "The name of the SSH key pair associated with the EC2 instance for secure access."
  type = string
}

# Variables for the Load Balancer module
variable "public_lb_Name" {
  description = "The name of the public load balancer"
  type        = string
}
variable "private_lb_Name" {
  description = "The name of the private load balancer"
  type        = string
}




