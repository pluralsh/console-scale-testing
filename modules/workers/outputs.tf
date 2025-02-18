output "worker_ids" {
  description = "List of worker node instance IDs"
  value       = module.worker_nodes[*].id
}

output "private_ips" {
  description = "List of private IPs for worker nodes"
  value       = module.worker_nodes[*].private_ip
}
