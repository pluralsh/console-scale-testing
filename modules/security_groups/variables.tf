variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "bastion_sg_name" {
  description = "Name of the Bastion security group"
  type        = string
  default     = "bastion-sg"
}

variable "worker_sg_name" {
  description = "Name of the Worker security group"
  type        = string
  default     = "worker-sg"
}
