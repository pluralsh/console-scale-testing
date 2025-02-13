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

            # Set environment variables
            echo "PLURAL_CONSOLE_URL=${var.plural_console_url}" | sudo tee -a /etc/environment
            echo "PLURAL_CONSOLE_TOKEN=${var.plural_console_token}" | sudo tee -a /etc/environment

            echo "export PLURAL_CONSOLE_URL=${var.plural_console_url}" | sudo tee -a /etc/profile.d/plural_env.sh
            echo "export PLURAL_CONSOLE_TOKEN=${var.plural_console_token}" | sudo tee -a /etc/profile.d/plural_env.sh
            sudo chmod +x /etc/profile.d/plural_env.sh

            # Download and execute the install script
            curl -o /tmp/plural-deployment-operator-install.sh https://raw.githubusercontent.com/pluralsh/console-scale-testing/refs/heads/feat/jb-console-scale-testing/workernode-scripts/plural-deployment-operator-install.sh
            chmod +x /tmp/plural-deployment-operator-install.sh
            /tmp/plural-deployment-operator-install.sh
  EOF


  tags = {
    Name = var.worker_name
  }
}
