module "worker_nodes" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name          = var.worker_name
  ami           = var.worker_ami
  instance_type = var.worker_instance_type
  key_name      = var.key_name
  count         = var.worker_count

  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.worker_sg_id]

  user_data = <<EOF
              #!/bin/bash
              curl -O https://myscript.com/script.sh
              chmod +x script.sh
              ./script.sh
              EOF

  tags = {
    Name = var.worker_name
  }
}
