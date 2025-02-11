module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "bastion-host"

  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2023 (update for your region)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.bastion_key.key_name 
  subnet_id     = module.vpc.public_subnets[0]  # Deploy in public subnet

  associate_public_ip_address = true

  vpc_security_group_ids = [module.bastion_sg.security_group_id]

  tags = {
    Name = "bastion-host"
  }
}
