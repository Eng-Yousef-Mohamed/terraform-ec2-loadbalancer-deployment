variable "vpc_cidr_block" {
  description = "this is cidr block of created vpc "
  type = string

}

variable "private_subnets_cidr" {
  description = "cider blocks for private subnets"
  type = list(string)
}

variable "public_subnets_cidr" {
  description = "cider blocks for public subnets"
  type = list(string)
}

variable "vpc_Name" {
  description = "this name vpc "
  type = string
}


variable "availability_Zones_subnet" {
  description = "Availability Zones subnet for each subnet"
  type = list(string)
}


variable "allow_nat_gateway" {
  description = "allow to creat internt nat gateway"
  type = bool
}