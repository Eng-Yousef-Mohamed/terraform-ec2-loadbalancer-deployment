
module "vpc_mod" {
  source = "./modules/vpc"
  vpc_Name = var.vpc_Name
  vpc_cidr_block = var.vpc_cidr_block
  public_subnets_cidr = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_Zones_subnet = var.availability_Zones_subnet
  allow_nat_gateway = var.allow_nat_gateway
}

module "ec2_mod" {
  
  source = "./modules/ec2-instance"
  Name = var.ec2_Name
  public_subnet_id = module.vpc_mod.public_subnet_ids
  private_subnet_id = module.vpc_mod.private_subnet_ids
  vpc_id =  module.vpc_mod.vpc_id
  ami_id = var.ami_id
  instance_type = var.instance_type
  load_balancer_dns = module.public_load_balancer_mod.load_balancer_dns

}

module "public_load_balancer_mod" {
  source = "./modules/load-balancer"
  Name = var.public_lb_Name
  ec2_ids = module.ec2_mod.public_ec2_ids
  vpc_id = module.vpc_mod.vpc_id
  subnet_ids = module.vpc_mod.public_subnet_ids
  security_group_id = module.ec2_mod.public_security_group_id
  
}
module "private_load_balancer_mod" {
  source = "./modules/load-balancer"
  Name = var.private_lb_Name
  ec2_ids = module.ec2_mod.private_ec2_ids
  vpc_id = module.vpc_mod.vpc_id
  subnet_ids = module.vpc_mod.public_subnet_ids
  security_group_id = module.ec2_mod.private_security_group_id
  
}
