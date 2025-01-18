# 🔄 Blue-Green Deployment with Traffic Splitting
![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)

Advanced implementation of blue-green deployment pattern in Kubernetes with sophisticated traffic splitting using NGINX Ingress Controller.

## 🎯 Overview
This project demonstrates a production-grade blue-green deployment strategy with traffic splitting capabilities, allowing for zero-downtime deployments and gradual traffic migration between versions.

## 📂 Project Structure
```
kubernetes/
├── blue-app/
│   ├── deployment.yaml
│   └── service.yaml
├── green-app/
│   ├── deployment.yaml
│   └── service.yaml
└── ingress/
    └── ingress.yaml
```

## 🌟 Features
- Zero-downtime deployments
- 75/25 traffic splitting between versions
- Advanced NGINX Ingress configuration
- Independent scaling of environments
- Automated health checks
- Instant rollback capability

## 🚀 Quick Start

### Prerequisites
- Minikube
- kubectl
- NGINX Ingress Controller

### Deployment Steps
```bash
# Apply blue application
kubectl apply -f blue-app/

# Apply green application
kubectl apply -f green-app/

# Configure traffic routing
kubectl apply -f ingress/
```

## 🔍 Verification
```bash
# Check deployments
kubectl get deployments

# Verify services
kubectl get svc

# Check ingress rules
kubectl get ingress
```

## 📈 Monitoring
- Deployment status monitoring
- Traffic distribution verification
- Health check status
- Resource utilization tracking

## 🔄 Rollback Procedure
1. Adjust ingress weights (100/0)
2. Scale down problematic deployment
3. Verify traffic routing
4. Monitor application health

## 🔗 Related Links
- [Main Project Documentation](../README.md)
- [Infrastructure Automation Project](../terraform/README.md)

## 📝 License
MIT License - see the [LICENSE](../LICENSE) file for details.
