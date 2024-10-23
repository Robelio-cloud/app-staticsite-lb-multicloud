provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./modules/network"
}

module "compute" {
  source                 = "./modules/compute"
  subnet1a_id            = module.network.subnet1a_id
  subnet1c_id            = module.network.subnet1c_id
  vpc_security_group_ids = module.network.sglb_id
  elb_security_group_id  = module.network.sglb_id
}
