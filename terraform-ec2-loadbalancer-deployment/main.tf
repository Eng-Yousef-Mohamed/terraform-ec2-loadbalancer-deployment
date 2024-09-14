
module "vpc_mod" {
  source = "./modules/vpc"
  vpc_Name = "vpc-test"
  vpc_cidr_block = "10.0.0.0/16"
  public_subnets_cidr = ["10.0.1.0/24","10.0.2.0/24"]
  private_subnets_cidr = ["10.0.3.0/24","10.0.4.0/24"]
  availability_Zones_subnet =["eu-north-1a","eu-north-1b"]
  allow_nat_gateway = true
}

module "ec2_mod" {
  
  source = "./modules/ec2-instance"
  Name = "test1"
  public_subnet_id = module.vpc_mod.public_subnet_ids
  private_subnet_id = module.vpc_mod.private_subnet_ids
  vpc_id = module.vpc_mod.vpc_id
  ami_id = "ami-090abff6ae1141d7d"
  instance_type = "t3.micro"
  load_balancer_dns = module.private_load_balancer_mod.load_balancer_dns
}

module "public_load_balancer_mod" {
  source = "./modules/load-balancer"
  Name = "public"
  ec2_ids = module.ec2_mod.public_ec2_ids
  vpc_id = module.vpc_mod.vpc_id
  subnet_ids = module.vpc_mod.public_subnet_ids
  security_group_id = module.ec2_mod.public_security_group_id
  
}
module "private_load_balancer_mod" {
  source = "./modules/load-balancer"
  Name = "private"
  ec2_ids = module.ec2_mod.private_ec2_ids
  vpc_id = module.vpc_mod.vpc_id
  subnet_ids = module.vpc_mod.private_subnet_ids
  security_group_id = module.ec2_mod.private_security_group_id
  
}

