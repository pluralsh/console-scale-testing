module "worker_nodes" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name          = var.worker_name
  ami           = var.worker_ami
  instance_type = var.worker_instance_type
  key_name      = var.key_name
  count         = var.worker_count

  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.worker_sg_id]

  user_data = <<-EOF
            #!/bin/bash -e

            cd ~

            # Set environment variables
            export PLURAL_CONSOLE_URL=${var.plural_console_url}
            export PLURAL_CONSOLE_TOKEN=${var.plural_console_token}

            # Download and execute the install script
            curl -o ./plural-deployment-operator-install.sh https://raw.githubusercontent.com/pluralsh/console-scale-testing/refs/heads/master/workernode-scripts/plural-deployment-operator-install.sh
            chmod +x ./plural-deployment-operator-install.sh
            ./plural-deployment-operator-install.sh
  EOF


  tags = {
    Name = var.worker_name
  }
}
