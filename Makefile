.PHONY: clean run

run:
	@echo "Initializing Terraform..."
	terraform init

	@echo "Planning Terraform deployment..."
	terraform plan -parallelism=250 -var="plural_console_url=$(PLURAL_CONSOLE_URL)" -var="plural_console_token=$(PLURAL_CONSOLE_TOKEN)"

	@echo "Applying Terraform configuration..."
	terraform apply -parallelism=250 -var="plural_console_url=$(PLURAL_CONSOLE_URL)" -var="plural_console_token=$(PLURAL_CONSOLE_TOKEN)"

	@echo "Terraform apply complete!"


clean:
	@echo "Destroying all Terraform-managed resources..."
	terraform destroy -var="plural_console_url=$(PLURAL_CONSOLE_URL)" -var="plural_console_token=$(PLURAL_CONSOLE_TOKEN)"

	@echo "🗑 Removing Terraform state files..."
	rm -rf .terraform terraform.tfstate* terraform.lock.hcl

	@echo "Cleanup complete!"

bastion:
	@chmod 600 ./bastion-key.pem
	scp -i ./bastion-key.pem ./bastion-key.pem ubuntu@$(BASTION_IP):/home/ubuntu/bastion-key.pem

ssh:
	ssh -i ./bastion-key.pem ubuntu@$(BASTION_IP)