
# Create vpc with specific cider block 
resource "aws_vpc" "aws_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_Name,
    created-by="Yousef"
  }
}

# Create public subnets with specific cider block 
resource "aws_subnet" "public_subnet" {
  count =length(var.public_subnets_cidr)
  vpc_id = aws_vpc.aws_vpc.id
  cidr_block =var.public_subnets_cidr[count.index]
  availability_zone = var.availability_Zones_subnet[count.index]
 tags = {
    Name = "public-subnet-${count.index + 1}"
    created-by="Yousef"
  }

}

# Create private subnets with specific cider block 
resource "aws_subnet" "private_subnet" {
  count =length(var.private_subnets_cidr)
  vpc_id = aws_vpc.aws_vpc.id
  cidr_block =var.private_subnets_cidr[count.index]
  availability_zone = var.availability_Zones_subnet[count.index]
 tags = {
    Name = "private-subnet-${count.index + 1}"
    created-by="Yousef"
  }

}

# Create an internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  count = length(var.public_subnets_cidr) > 0 ? 1 : 0  
  vpc_id =  aws_vpc.aws_vpc.id

  tags = {
    Name = "internet_gateway_${var.vpc_Name}"
    created-by="Yousef"
  }

}

# Create a route table for public subnets
resource "aws_route_table" "public_route_table" {
  count = length(var.public_subnets_cidr) > 0 ? 1 : 0  #use to prevent creation of rw if not public subnet entered 
  vpc_id =  aws_vpc.aws_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway[0].id
  }

  tags = {
    Name = "route_table_${var.vpc_Name}"
    created-by="Yousef"
  }
}

# Create a route table for private subnets
resource "aws_route_table" "private_route_table" {
  count = length(var.private_subnets_cidr) > 0 ? 1 : 0  #use to prevent creation of rw if not private subnet entered 
  vpc_id =  aws_vpc.aws_vpc.id
  route {
    cidr_block              = "0.0.0.0/0"
    nat_gateway_id          = aws_nat_gateway.nat_gateway[0].id
  }
  tags = {
    Name = "private_route_table_${var.vpc_Name}"
    created-by="Yousef"
  }
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "public_association" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table[0].id
  
}
# Associate private subnets with the public route table
resource "aws_route_table_association" "private_association" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table[0].id
}

# Create an Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  count = var.allow_nat_gateway ? 1 : 0
  domain = "vpc"


}

#Create the NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  count =  var.allow_nat_gateway  ? 1 : 0
  subnet_id = aws_subnet.public_subnet[0].id
  allocation_id = aws_eip.nat_eip[0].id


  tags = {
    Name = "nat_gateway_${var.vpc_Name}"
    created-by = "Yousef"
  }
}