terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.170.0"
    }
  }
}

variable "bucket_name" {}
variable "service_account_id" {}

resource "yandex_storage_bucket" "bucket" {
  access_key = yandex_iam_service_account_static_access_key.key.access_key
  secret_key = yandex_iam_service_account_static_access_key.key.secret_key
  bucket     = var.bucket_name
  force_destroy = true
}

resource "yandex_iam_service_account_static_access_key" "key" {
  service_account_id = var.service_account_id
  description        = "key for object storage"
}

output "bucket_name" { value = yandex_storage_bucket.bucket.bucket }
