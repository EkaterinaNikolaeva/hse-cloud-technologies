terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.170.0"
    }
  }
}

variable "name_prefix" {}
variable "subnets" {}
variable "zone" {}

resource "yandex_vpc_network" "this" {
  name = "${var.name_prefix}-private"
}

resource "yandex_vpc_subnet" "this" {
  name           = keys(var.subnets)[0]
  zone           = var.zone
  v4_cidr_blocks = var.subnets[keys(var.subnets)[0]]
  network_id     = yandex_vpc_network.this.id
}

output "network_id" { value = yandex_vpc_network.this.id }
output "subnet_id"  { value = yandex_vpc_subnet.this.id }
