output "instance_ip" {
  value = module.compute.public_ip
}

output "db_endpoint" {
  value = module.db.db_endpoint
}

output "bucket_name" {
  value = module.object_storage.bucket_name
}
