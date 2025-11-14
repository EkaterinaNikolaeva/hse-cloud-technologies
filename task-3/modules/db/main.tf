terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.170.0"
    }
  }
}

variable "db_name" {}
variable "db_user" {}
variable "db_pass" {
  sensitive = true
}
variable "zone" {}
variable "subnet_id" {}
variable "network_id" {}

resource "yandex_mdb_mysql_cluster" "db" {
  name = var.db_name
  environment = "PRESTABLE"
  network_id = var.network_id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  host {
    zone = var.zone
    subnet_id = var.subnet_id
  }

  mysql_config = {
    sql_mode                      = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
    max_connections               = 100
    default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
    innodb_print_all_deadlocks    = true
  }
}

resource "yandex_mdb_mysql_user" "db_user" {
  cluster_id = yandex_mdb_mysql_cluster.db.id
  name       = var.db_user
  password   = var.db_pass
}

output "db_endpoint" {
  value = yandex_mdb_mysql_cluster.db.host[0].fqdn
}
