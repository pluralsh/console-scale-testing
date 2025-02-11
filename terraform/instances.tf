module "worker_nodes" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name           = "worker-node"
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2023 (update if needed)
  instance_type = "t2.nano"
  key_name      = aws_key_pair.bastion_key.key_name  # Use the same key pair

  count = 5  # Number of worker nodes

  subnet_id = module.vpc.private_subnets[0]  # Deploy in private subnet

  vpc_security_group_ids = [module.worker_sg.security_group_id]  # Attach worker SG

  tags = {
    Name = "worker-node"
  }
}
