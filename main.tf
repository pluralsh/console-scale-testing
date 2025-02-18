module "vpc" {
  source = "./modules/vpc"

  vpc_name           = "console-scale-testing-vpc"
  azs                = ["us-east-2a", "us-east-2b", "us-east-2c"]
  enable_nat_gateway = true
  enable_vpn_gateway = false
}

module "bastion" {
  source = "./modules/bastion"

  bastion_name          = "bastion-host"
  bastion_ami           = "ami-0cb91c7de36eed2cb"
  bastion_instance_type = "t2.micro"
  key_name              = aws_key_pair.bastion_key.key_name
  public_subnet_id      = module.vpc.public_subnets[0]
  bastion_sg_id         = module.security_groups.bastion_sg_id
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id          = module.vpc.vpc_id
  bastion_sg_name = "bastion-sg"
  worker_sg_name  = "worker-sg"
}


module "workers-a" {
  source = "./modules/workers"

  worker_name            = "worker-node"
  worker_ami             = "ami-0cb91c7de36eed2cb"
  worker_instance_type   = "t3.medium"
  key_name               = aws_key_pair.bastion_key.key_name
  worker_count           = 0
  private_subnet_id      = module.vpc.private_subnets[0]
  worker_sg_id           = module.security_groups.worker_sg_id
  plural_console_url     = var.plural_console_url
  plural_console_token   = var.plural_console_token
  dockerhub_username     = var.dockerhub_username
  dockerhub_access_token = var.dockerhub_access_token
}

module "workers-b" {
  source = "./modules/workers"

  worker_name            = "worker-node"
  worker_ami             = "ami-0cb91c7de36eed2cb"
  worker_instance_type   = "t3.medium"
  key_name               = aws_key_pair.bastion_key.key_name
  worker_count           = 0
  private_subnet_id      = module.vpc.private_subnets[0]
  worker_sg_id           = module.security_groups.worker_sg_id
  plural_console_url     = var.plural_console_url
  plural_console_token   = var.plural_console_token
  dockerhub_username     = var.dockerhub_username
  dockerhub_access_token = var.dockerhub_access_token
}

module "workers-c" {
  source = "./modules/workers"

  worker_name            = "worker-node"
  worker_ami             = "ami-0cb91c7de36eed2cb"
  worker_instance_type   = "t3.medium"
  key_name               = aws_key_pair.bastion_key.key_name
  worker_count           = 0
  private_subnet_id      = module.vpc.private_subnets[2]
  worker_sg_id           = module.security_groups.worker_sg_id
  plural_console_url     = var.plural_console_url
  plural_console_token   = var.plural_console_token
  dockerhub_username     = var.dockerhub_username
  dockerhub_access_token = var.dockerhub_access_token
}

resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion-key-mjg"
  public_key = tls_private_key.bastion_key.public_key_openssh
}

resource "local_file" "bastion_private_key" {
  content         = tls_private_key.bastion_key.private_key_pem
  filename        = "${path.module}/bastion-key.pem"
  file_permission = "0600"
}

variable "plural_console_url" {
  description = "Plural Console URL"
  type        = string
}

variable "plural_console_token" {
  description = "Plural Console Token"
  type        = string
  sensitive   = true
}

variable "dockerhub_username" {
  description = "Docker Hub username"
  type        = string
}

variable "dockerhub_access_token" {
  description = "Docker Hub Access Token"
  type        = string
  sensitive   = true
}
