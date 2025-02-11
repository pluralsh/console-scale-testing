data "http" "my_ip" {
  url = "https://ifconfig.me"
}

module "bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  name    = "bastion-sg"
  vpc_id  = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH from my IP"
      cidr_blocks = "${chomp(data.http.my_ip.body)}/32"  # Restrict to your IP
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "worker_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  name    = "worker-sg"
  vpc_id  = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      source_security_group_id = module.bastion_sg.security_group_id
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "rds_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  name    = "rds-sg"
  vpc_id  = module.vpc.vpc_id

  # Allow Postgres (port 5432) access from Worker Nodes only
  ingress_with_source_security_group_id = [
    {
      from_port                = 5432
      to_port                  = 5432
      protocol                 = "tcp"
      source_security_group_id = module.worker_sg.security_group_id
    }
  ]

  # Allow all outbound traffic from the database
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
