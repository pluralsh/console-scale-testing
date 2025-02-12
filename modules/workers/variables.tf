variable "worker_name" {
  description = "Name of the worker node instances"
  type        = string
  default     = "worker-node"
}

variable "worker_ami" {
  description = "AMI for the worker nodes"
  type        = string
  default     = "ami-0cb91c7de36eed2cb"  # Ubuntu 24.04
}

variable "worker_instance_type" {
  description = "Instance type for the worker nodes"
  type        = string
  default     = "t2.nano"
}

variable "key_name" {
  description = "SSH key pair name for worker nodes"
  type        = string
}

variable "worker_count" {
  description = "Number of worker nodes to deploy"
  type        = number
  default     = 5
}

variable "private_subnet_id" {
  description = "Private subnet ID where worker nodes will be deployed"
  type        = string
}

variable "worker_sg_id" {
  description = "Security Group ID for worker nodes"
  type        = string
}
