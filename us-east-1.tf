module "use1-vpc" {
  source = "./modules/vpc"

  vpc_name           = "console-scale-testing-vpc"
  azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
  enable_nat_gateway = true
  enable_vpn_gateway = false

  providers = {
    aws = aws.us-east-1
  }
}

module "use1-bastion" {
  source = "./modules/bastion"

  bastion_name          = "bastion-host"
  bastion_ami           = local.amis.use1
  bastion_instance_type = "t2.micro"
  key_name              = aws_key_pair.use1-bastion_key.key_name
  public_subnet_id      = module.use1-vpc.public_subnets[0]
  bastion_sg_id         = module.use1-security_groups.bastion_sg_id

  providers = {
    aws = aws.us-east-1
  }
}

module "use1-security_groups" {
  source = "./modules/security_groups"

  vpc_id          = module.use1-vpc.vpc_id
  bastion_sg_name = "bastion-sg"
  worker_sg_name  = "worker-sg"

  providers = {
    aws = aws.us-east-1
  }
}


module "use1-workers-a" {
  source = "./modules/workers"

  worker_name            = "worker-node"
  worker_ami             = local.amis.use1
  worker_instance_type   = "t3.medium"
  key_name               = aws_key_pair.use1-bastion_key.key_name
  worker_count           = 0
  private_subnet_id      = module.use1-vpc.private_subnets[0]
  worker_sg_id           = module.use1-security_groups.worker_sg_id
  plural_console_url     = var.plural_console_url
  plural_console_token   = var.plural_console_token
  dockerhub_username     = var.dockerhub_username
  dockerhub_access_token = var.dockerhub_access_token

  providers = {
    aws = aws.us-east-1
  }
}

module "use1-workers-b" {
  source = "./modules/workers"

  worker_name            = "worker-node"
  worker_ami             = local.amis.use1
  worker_instance_type   = "t3.medium"
  key_name               = aws_key_pair.use1-bastion_key.key_name
  worker_count           = 0
  private_subnet_id      = module.use1-vpc.private_subnets[0]
  worker_sg_id           = module.use1-security_groups.worker_sg_id
  plural_console_url     = var.plural_console_url
  plural_console_token   = var.plural_console_token
  dockerhub_username     = var.dockerhub_username
  dockerhub_access_token = var.dockerhub_access_token

  providers = {
    aws = aws.us-east-1
  }
}

module "use1-workers-c" {
  source = "./modules/workers"

  worker_name            = "worker-node"
  worker_ami             = local.amis.use1
  worker_instance_type   = "t3.medium"
  key_name               = aws_key_pair.use1-bastion_key.key_name
  worker_count           = 0
  private_subnet_id      = module.use1-vpc.private_subnets[2]
  worker_sg_id           = module.use1-security_groups.worker_sg_id
  plural_console_url     = var.plural_console_url
  plural_console_token   = var.plural_console_token
  dockerhub_username     = var.dockerhub_username
  dockerhub_access_token = var.dockerhub_access_token

  providers = {
    aws = aws.us-east-1
  }
}

resource "aws_key_pair" "use1-bastion_key" {
  key_name   = "bastion-key-mjg"
  public_key = tls_private_key.use1-bastion_key.public_key_openssh
  provider = aws.us-east-1
}

resource "tls_private_key" "use1-bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "use1-bastion_private_key" {
  content         = tls_private_key.bastion_key.private_key_pem
  filename        = "${path.module}/use1-bastion-key.pem"
  file_permission = "0600"
}