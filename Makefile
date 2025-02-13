.PHONY: clean run

run:
	@echo "Initializing Terraform..."
	terraform init

	@echo "Planning Terraform deployment..."
	terraform plan -var="plural_console_url=$(PLURAL_CONSOLE_URL)" -var="plural_console_token=$(PLURAL_CONSOLE_TOKEN)"

	@echo "Applying Terraform configuration..."
	terraform apply -var="plural_console_url=$(PLURAL_CONSOLE_URL)" -var="plural_console_token=$(PLURAL_CONSOLE_TOKEN)" -auto-approve

	@echo "Terraform apply complete!"


clean:
	@echo "Destroying all Terraform-managed resources..."
	terraform destroy -auto-approve

	@echo "🗑 Removing Terraform state files..."
	rm -rf .terraform terraform.tfstate* terraform.lock.hcl

	@echo "Cleanup complete!"