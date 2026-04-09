module "network" {
  source   = "./modules/network"
  vpc_name = var.vpc_name
  net_cidr = var.net_cidr
}

module "security" {
  source             = "./modules/security"
  vpc_name           = var.vpc_name
  network_id         = module.network.network_id
  trusted_ip_for_ssh = var.trusted_ip_for_ssh
}

module "compute" {
  source        = "./modules/compute"
  vm_name       = var.vm_name
  zone          = var.zone
  platform_id   = var.platform_id
  cores         = var.cores
  memory        = var.memory
  core_fraction = var.core_fraction
  disk_type     = var.disk_type
  disk_size     = var.disk_size
  image_family  = var.image_family
  subnet_id     = module.network.subnet_ids[var.zone]
  nat           = var.nat
  sg_id         = module.security.sg_id
  ssh_key       = local.yc_ssh_pub
}
