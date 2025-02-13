# VPC Outputs
output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

# Bastion Outputs
output "bastion_id" {
  description = "The ID of the Bastion instance"
  value       = module.bastion.bastion_id
}

output "bastion_public_ip" {
  description = "Public IP of the Bastion instance"
  value       = module.bastion.bastion_public_ip
}

output "bastion_private_ip" {
  description = "Private IP of the Bastion instance"
  value       = module.bastion.bastion_private_ip
}

# Worker Nodes Outputs
output "worker_instance_ids" {
  description = "List of Worker Node instance IDs"
  value       = module.workers.worker_ids
}

output "worker_private_ips" {
  description = "List of private IPs for Worker Nodes"
  value       = module.workers.worker_private_ips
}

# Security Groups Outputs
output "bastion_security_group_id" {
  description = "Security Group ID for the Bastion Host"
  value       = module.security_groups.bastion_sg_id
}

output "worker_security_group_id" {
  description = "Security Group ID for the Worker Nodes"
  value       = module.security_groups.worker_sg_id
}

# SSH Key Outputs
output "bastion_private_key_path" {
  description = "Path to the generated SSH private key"
  value       = local_file.bastion_private_key.filename
  sensitive   = true
}
