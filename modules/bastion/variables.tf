variable "bastion_name" {
  description = "The name of the bastion host"
  type        = string
  default     = "bastion-host"
}

variable "bastion_ami" {
  description = "AMI for the bastion instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2023 (update as needed)
}

variable "bastion_instance_type" {
  description = "Instance type for the bastion host"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name for access"
  type        = string
}

variable "public_subnet_id" {
  description = "Subnet ID where the bastion host will be deployed"
  type        = string
}

variable "bastion_sg_id" {
  description = "Security Group ID for the bastion host"
  type        = string
}
