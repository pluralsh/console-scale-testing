output "bastion_host_public_ip" {
  description = "The public IP of the bastion host"
  value       = module.bastion.public_ip
}
