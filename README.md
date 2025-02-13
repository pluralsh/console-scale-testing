# Console Scale Testing Terraform Automation

This repository contains Terraform scripts to provision infrastructure for Console Scale Testing, along with a `Makefile` to simplify deployment and teardown.

## **Prerequisites**
Before running Terraform, ensure you have the following installed:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) (>= v1.0)
- [AWS CLI](https://aws.amazon.com/cli/)

---

## **Setup**
### **1. Configure AWS Credentials**
Enforcing AWS `us-east-2` for now. 

See provider.tf for correct profile. 

### 2. Environment Variables
export PLURAL_CONSOLE_URL="https://console.example.com"
export PLURAL_CONSOLE_TOKEN="your-secret-token"

### 3. Terraform Init, Plan, Apply
```sh
make run
```

### 4. Tear down all resources
```sh
make clean
```
