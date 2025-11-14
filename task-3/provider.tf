terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.170.0"
    }
  }
}

provider "yandex" {
  zone                     = "ru-central1-a"
  folder_id                = var.folder_id
  cloud_id                 = var.cloud_id
  token                    = var.token
}
