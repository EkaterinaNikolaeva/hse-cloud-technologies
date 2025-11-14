terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.170.0"
    }
  }
}

variable "name_prefix" {}
variable "zone" {}
variable "image_id" {}
variable "instance_resources" {}
variable "subnet_id" {}

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
    subnet_id = var.subnet_id
  }
}

output "public_ip" {
  value = yandex_compute_instance.this.network_interface[0].nat_ip_address
}
