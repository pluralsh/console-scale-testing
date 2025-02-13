output "bastion_id" {
  description = "The ID of the Bastion instance"
  value       = module.bastion.id
}

output "bastion_public_ip" {
  description = "The public IP of the Bastion instance"
  value       = module.bastion.public_ip
}

output "bastion_private_ip" {
  description = "The private IP of the Bastion instance"
  value       = module.bastion.private_ip
}
