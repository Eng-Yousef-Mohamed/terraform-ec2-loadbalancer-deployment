variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "ec2_ids" {
  type = list(string)
}

variable "HTTP_port" {
  type = string
  default = "80"
}


variable "security_group_id" {
  type = string
}
variable "Name" {
  type = string
}