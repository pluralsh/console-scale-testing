variable "allowed_ssh_ip" {
  description = "The IP allowed to access the bastion host via SSH"
  type        = string
  default     = ""  # Leave blank to enforce required input
}
