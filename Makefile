.PHONY: clean

clean:
	@echo "Destroying all Terraform-managed resources..."
	terraform destroy -auto-approve

	@echo "🗑 Removing Terraform state files..."
	rm -rf .terraform terraform.tfstate* terraform.lock.hcl

	@echo "Cleanup complete!"