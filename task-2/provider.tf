terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
    random = {
      source  = "hashicorp/random"
    }
  }
}

provider "yandex" {
  zone                     = "ru-central1-a"
  folder_id                = var.folder_id
}

provider "random" {
} 
