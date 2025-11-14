variable "name_prefix" {
  type        = string
  default     = "tf-task-3"
}

variable "token" {
  type      = string
  sensitive = true
}

variable "folder_id" {
  type        = string  
}

variable "zone" {
  type        = string
  default     = "ru-central1-a"
}

variable "cloud_id" {
  type        = string  
}

// network

variable "network_name" {
  type        = string  
}

variable "subnets" {
  type        = map(list(string))
  default = {
    "private-subnet" = ["192.168.10.0/24"],
  }
}

// compute

variable "instance_name" {
  type    = string
  default = "app-instance"
    
}
variable "image_id" {
  type        = string
  default     = "fd8ba9d5mfvlncknt2kd"
}

variable "instance_resources" {
  type = object({
    platform_id = optional(string, "standard-v3")
    cores       = number
    memory      = number
    disk = optional(object({
      disk_type = optional(string, "network-ssd")
      disk_size = optional(number, 15)
    }), {})
  })
}

// db

variable "db_name" {
  type        = string
  default     = "db1"
}

variable "db_user" {
  type        = string
  default     = "appuser"
}

variable "db_pass" {
  type      = string
  sensitive = true
}

variable "db_disk_size" {
    type = number
    default = 10
}

// S3

variable "bucket_name_suffix" {
  type        = string
  default     = "tf-task-3"
}


