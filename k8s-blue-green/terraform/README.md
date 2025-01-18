# ⚙️ Kubernetes Infrastructure Automation with Terraform
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)

Automated Kubernetes infrastructure deployment using Terraform, featuring modular architecture and dynamic resource management.

## 🎯 Overview
This project showcases infrastructure automation using Terraform, implementing a reusable and scalable approach to Kubernetes resource management.

## 📂 Project Structure
```
terraform/
├── applications.json
├── main.tf
├── modules/
│   └── kubernetes_app/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── terraform.tfstate
└── terraform.tfstate.backup
```

## 🌟 Features
- Complete infrastructure as code
- Modular Terraform configuration
- Dynamic resource allocation
- State management
- Automated deployments
- Reusable components

## 🚀 Quick Start

### Prerequisites
- Terraform
- Kubernetes cluster (e.g., Minikube)
- kubectl configured

### Deployment Steps
```bash
# Initialize Terraform
terraform init

# Review changes
terraform plan

# Apply configuration
terraform apply
```

## 🔍 Verification
```bash
# Check Terraform state
terraform show

# Verify Kubernetes resources
kubectl get all -n your-namespace

# View module outputs
terraform output
```

## 📊 Resource Management
- Dynamic scaling configuration
- Resource limits and requests
- State file management
- Module reusability

## 🔄 Update Procedure
1. Modify configuration files
2. Run terraform plan
3. Apply changes
4. Verify deployment

## 🔗 Related Links
- [Blue-Green Deployment Project](../kubernetes/README.md)

## 📝 License
MIT License - see the [LICENSE](../LICENSE) file for details.
