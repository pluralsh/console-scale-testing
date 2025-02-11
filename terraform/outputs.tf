output "bastion_host_public_ip" {
  description = "The public IP of the bastion host"
  value       = module.bastion.public_ip
}

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.plural_db.endpoint
}
