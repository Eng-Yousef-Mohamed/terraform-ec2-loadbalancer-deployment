# Values for the VPC module
vpc_Name = "vpc-test"
vpc_cidr_block = "10.0.0.0/16"
public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
availability_Zones_subnet = ["eu-north-1a", "eu-north-1b"]
allow_nat_gateway = false

# Values for the EC2 module
ec2_Name = "test1"
ami_id = "ami-090abff6ae1141d7d"
instance_type = "t3.micro"

# Values for the Public Load Balancer module
public_lb_Name = "public"

# Values for the Private Load Balancer module
private_lb_Name = "private"
