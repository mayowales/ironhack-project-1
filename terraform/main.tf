# Call the Network Module
module "network" {
  source               = "./modules/networking"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  vpc_name             = var.vpc_name
}

# Call the Compute Module
module "compute" {
  source   = "./modules/compute"
  vpc_id   = module.network.vpc_id
  vpc_cidr = module.network.vpc_cidr_block
  # We take the first ID from the list outputs
  public_subnet_id  = module.network.public_subnet_ids[0]
  private_subnet_id = module.network.private_subnet_ids[0]

  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  instance_map  = var.instance_map
}
