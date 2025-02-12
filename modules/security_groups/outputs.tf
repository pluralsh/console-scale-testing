output "bastion_sg_id" {
  description = "Security Group ID for the Bastion Host"
  value       = module.bastion_sg.security_group_id
}

output "worker_sg_id" {
  description = "Security Group ID for the Worker Nodes"
  value       = module.worker_sg.security_group_id
}
