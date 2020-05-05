output "instance_id" {
  value       = "${module.gitlab_db.instance_id}"
  description = "ID of the instance"
}

output "instance_address" {
  value       = "${module.gitlab_db.instance_address}"
  description = "Address of the instance"
}

output "instance_endpoint" {
  value       = "${module.gitlab_db.instance_endpoint}"
  description = "DNS Endpoint of the instance"
}
