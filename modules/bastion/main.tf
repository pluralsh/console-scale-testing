module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name           = var.bastion_name
  ami            = var.bastion_ami
  instance_type  = var.bastion_instance_type
  key_name       = var.key_name
  subnet_id      = var.public_subnet_id
  vpc_security_group_ids = [var.bastion_sg_id]

  associate_public_ip_address = true

  tags = {
    Name = var.bastion_name
  }
}
