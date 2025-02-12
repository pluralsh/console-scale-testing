module "vpc" {
  source = "./modules/vpc"

  vpc_name         = "console-scale-testing-vpc"
  vpc_cidr         = "10.0.0.0/16"
  azs              = ["us-east-2a", "us-east-2b"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  enable_nat_gateway = true
  enable_vpn_gateway = false
}

module "bastion" {
  source = "./modules/bastion"

  bastion_name        = "bastion-host"
  bastion_ami         = "ami-0c55b159cbfafe1f0"
  bastion_instance_type = "t2.micro"
  key_name        = aws_key_pair.bastion_key.key_name
  public_subnet_id    = module.vpc.public_subnets[0]
  bastion_sg_id       = module.security_groups.bastion_sg_id
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id          = module.vpc.vpc_id
  bastion_sg_name = "bastion-sg"
  worker_sg_name  = "worker-sg"
}


module "workers" {
  source = "./modules/workers"

  worker_name         = "worker-node"
  worker_ami          = "ami-0c55b159cbfafe1f0"
  worker_instance_type = "t2.nano"
  key_name        = aws_key_pair.bastion_key.key_name
  worker_count        = 5
  private_subnet_id   = module.vpc.private_subnets[0]
  worker_sg_id        = module.security_groups.worker_sg_id
}

resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion-key"
  public_key = tls_private_key.bastion_key.public_key_openssh
}

resource "local_file" "bastion_private_key" {
  content  = tls_private_key.bastion_key.private_key_pem
  filename = "${path.module}/bastion-key.pem"
  file_permission = "0600"
}
