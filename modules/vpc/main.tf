resource "aws_vpc" "aws_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_Name,
    created-by="Yousef"
  }
}

resource "aws_subnet" "public_subnet" {
  count =length(var.public_subnets_cidr)
  vpc_id = aws_vpc.aws_vpc.id
  cidr_block =var.public_subnets_cidr[count.index]
  #availability_zone = var.Availability_Zones_subnet[count.index]
 tags = {
    Name = "public-subnet-${count.index + 1}"
    created-by="Yousef"
  }

}

resource "aws_subnet" "private_subnet" {
  count =length(var.private_subnets_cidr)
  vpc_id = aws_vpc.aws_vpc.id
  cidr_block =var.private_subnets_cidr[count.index]
  #availability_zone = var.Availability_Zones_subnet[count.index]
 tags = {
    Name = "private-subnet-${count.index + 1}"
    created-by="Yousef"
  }

}
