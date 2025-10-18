resource "yandex_vpc_network" "this" {
  name = "${var.name_prefix}-private"
}

resource "yandex_vpc_subnet" "private" {
  name           = keys(var.subnets)[0]
  zone           = var.zone
  v4_cidr_blocks = var.subnets[keys(var.subnets)[0]]
  network_id     = yandex_vpc_network.this.id
}

resource "yandex_compute_disk" "boot_disk" {
  name     = "${var.name_prefix}-boot-disk"
  zone     = var.zone
  image_id = var.image_id
  
  type = var.instance_resources.disk.disk_type
  size = var.instance_resources.disk.disk_size
}

resource "yandex_compute_instance" "this" {
  name                      = "${var.name_prefix}-linux-vm"
  allow_stopping_for_update = true
  platform_id               = var.instance_resources.platform_id
  zone                      = var.zone

  resources {
    cores  = var.instance_resources.cores
    memory = var.instance_resources.memory
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot_disk.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
  }
}

resource "random_string" "bucket_name" {
  length  = 8
  special = false
  upper   = false
} 

resource "yandex_ydb_database_serverless" "this" {
  name        = "${var.name_prefix}-ydb-serverless"
  location_id = "ru-central1"
}

resource "yandex_iam_service_account" "bucket" {
  name = "${var.name_prefix}-bucket-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "storage_editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.bucket.id}"
}

resource "yandex_iam_service_account_static_access_key" "this" {
  service_account_id = yandex_iam_service_account.bucket.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "this" {
  bucket     = "${var.name_prefix}-terraform-bucket-${random_string.bucket_name.result}"
  access_key = yandex_iam_service_account_static_access_key.this.access_key
  secret_key = yandex_iam_service_account_static_access_key.this.secret_key
  
  depends_on = [ yandex_resourcemanager_folder_iam_member.storage_editor ]
}
