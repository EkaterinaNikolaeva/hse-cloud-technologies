module "network" {
  source      = "./modules/network"
  name_prefix = var.name_prefix
  subnets     = var.subnets
  zone        = var.zone
}

module "db" {
  source    = "./modules/db" 
  db_name   = var.db_name
  db_user   = var.db_user
  db_pass   = var.db_pass
  zone      = var.zone
  subnet_id = module.network.subnet_id
  network_id = module.network.network_id
}

module "iam" {
  source      = "./modules/iam"
  name_prefix = var.name_prefix
  folder_id   = var.folder_id
}

module "compute" {
  source             = "./modules/compute"
  name_prefix        = var.name_prefix
  zone               = var.zone
  image_id           = var.image_id
  instance_resources = var.instance_resources
  subnet_id          = module.network.subnet_id
}

module "object_storage" {
    source = "./modules/object_storage"
    bucket_name = "${var.name_prefix}-${var.bucket_name_suffix}" 
    service_account_id = module.iam.sa_id
}
