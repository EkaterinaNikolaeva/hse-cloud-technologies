packer {
    required_plugins {
        yandex = {
            version = "~> 1"
            source  = "github.com/hashicorp/yandex"
        }
        
        ansible = {
            version = ">= 1.0.0"
            source  = "github.com/hashicorp/ansible"
        }
    }
}

variable "folder_id" {
  type    = string
  default = env("YC_FOLDER_ID")
}

variable "subnet_id" {
  type    = string
  default = env("YC_SUBNET_ID")
}

source "yandex" "ubuntu-flask-nginx" {
    folder_id           = var.folder_id
    source_image_family = "ubuntu-2204-lts"
    ssh_username        = "ubuntu"
    use_ipv4_nat        = "true"
    image_family        = "ubuntu-2204-lts"
    image_name          = "my-nginx-flask"
    subnet_id           = var.subnet_id
    disk_type           = "network-ssd"
    zone                = "ru-central1-b"
}

build {
    name = "yandex-flask-nginx"

    sources = [
        "source.yandex.ubuntu-flask-nginx"
    ]

    provisioner "ansible" {
        playbook_file = "ansible/playbook.yml"
    }
}
