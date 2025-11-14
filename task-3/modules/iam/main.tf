terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.170.0"
    }
  }
}

variable "name_prefix" {}
variable "folder_id" {}

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

output "sa_id" { 
  value = yandex_iam_service_account.bucket.id
}
