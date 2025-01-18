# 🚀 DevOps Project Portfolio
![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

This repository contains a collection of advanced DevOps projects demonstrating various deployment strategies and infrastructure automation techniques.

## 📂 Projects

### [Project 1: Blue-Green Deployment with Traffic Splitting]([kubernetes/README.md](https://github.com/Minhajms/nginx-blue-green-deployment/tree/master/k8s-blue-green/kubernetes))
Implementation of blue-green deployment pattern in Kubernetes with sophisticated traffic splitting using NGINX Ingress Controller.

**Key Features:**
- Zero-downtime deployments
- 75/25 traffic splitting
- NGINX Ingress configuration
- Automated health checks
- Instant rollback capability

### [Project 2: Infrastructure Automation with Terraform](terraform/README.md)
Automated Kubernetes infrastructure deployment using Terraform with modular architecture and dynamic resource management.

**Key Features:**
- Infrastructure as Code
- Modular Terraform configuration
- Dynamic resource allocation
- State management
- Automated deployments

## 🛠️ Project Structure
```
k8s-blue-green/
├── kubernetes/           # Project 1: Blue-Green Deployment
│   ├── blue-app/
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   ├── green-app/
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   └── ingress/
│       └── ingress.yaml
└── terraform/           # Project 2: Infrastructure Automation
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

## 📚 Documentation
Each project has its own detailed documentation:
- [Blue-Green Deployment Documentation](kubernetes/README.md)
- [Terraform Infrastructure Documentation](terraform/README.md)

## 🤝 Contributing
Contributions are welcome! Please check individual project directories for specific contribution guidelines.

## 📝 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
*⭐️ If you found these projects useful, please consider giving them a star!*

*Built with ❤️ for the DevOps community*
