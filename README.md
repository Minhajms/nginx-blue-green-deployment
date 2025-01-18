# Blue-Green Deployment with Traffic Splitting in Kubernetes

## 🚀 Overview

This repository demonstrates an advanced implementation of Blue-Green deployment pattern in Kubernetes, featuring sophisticated traffic splitting capabilities. The setup leverages Nginx Ingress Controller to achieve a 75/25 traffic distribution between blue and green environments, showcasing modern deployment strategies for high-availability applications.

## 📋 Prerequisites

- **Minikube** (Latest version)
- **kubectl** (Compatible with your cluster version)
- **Nginx Ingress Controller**
- Basic understanding of Kubernetes concepts

## 🏗️ Architecture

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

## 💫 Features

- **Zero-downtime deployments**
- **Gradual traffic shifting** (75/25 split)
- **Easy rollback capability**
- **Independent scaling** of blue and green environments
- **Advanced traffic management** using Nginx Ingress
- **Load balancing** across multiple replicas

## 🛠️ Implementation

### 1. Blue Application Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: blue-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: blue-app
  template:
    metadata:
      labels:
        app: blue-app
    spec:
      containers:
      - name: blue-app
        image: hashicorp/http-echo
        args:
        - -listen=:8080
        - -text="I am blue"
        ports:
        - containerPort: 8080
```

**Blue Service Configuration:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: blue-app-service
spec:
  selector:
    app: blue-app
  ports:
  - protocol: TCP
    port: 8080
    targetPort: 8080
```

### 2. Green Application Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: green-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: green-app
  template:
    metadata:
      labels:
        app: green-app
    spec:
      containers:
      - name: green-app
        image: hashicorp/http-echo
        args:
        - -listen=:8081
        - -text="I am green"
        ports:
        - containerPort: 8081
```

**Green Service Configuration:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: green-app-service
spec:
  selector:
    app: green-app
  ports:
  - protocol: TCP
    port: 8081
    targetPort: 8081
```

### 3. Ingress Configuration for Traffic Splitting

```yaml
# Primary Ingress (Blue App)
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: blue-green-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: blue-app-service
            port:
              number: 8080
---
# Canary Ingress (Green App)
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: green-canary-ingress
  annotations:
    nginx.ingress.kubernetes.io/canary: "true"
    nginx.ingress.kubernetes.io/canary-weight: "25"
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: green-app-service
            port:
              number: 8081
```

## 🚀 Deployment Steps

1. **Initialize Your Environment**
   ```bash
   minikube start
   ```

2. **Deploy Applications**
   ```bash
   kubectl apply -f blue-app/deployment.yaml
   kubectl apply -f blue-app/service.yaml
   kubectl apply -f green-app/deployment.yaml
   kubectl apply -f green-app/service.yaml
   ```

3. **Configure Traffic Routing**
   ```bash
   kubectl apply -f ingress/ingress.yaml
   ```

4. **Verify Deployment**
   ```bash
   kubectl get pods,svc,ingress
   ```

## 📊 Monitoring and Verification

- **Traffic Distribution:** 75% Blue / 25% Green
- **Health Checks:** Automated via Kubernetes probes
- **Metrics:** Available through Kubernetes dashboard
- **Logging:** Centralized through Nginx Ingress Controller

## 🔄 Rollback Procedure

In case of issues, quick rollback can be achieved by:
1. Adjusting ingress weights to 100/0
2. Removing the canary ingress
3. Scaling down the problematic deployment

## 🔰 Best Practices Implemented

- **Resource Management:** Proper resource requests and limits
- **High Availability:** Multiple replicas for each deployment
- **Security:** Network policies and service isolation
- **Scalability:** Independent scaling capabilities
- **Monitoring:** Built-in health checks and metrics

## 📈 Performance Considerations

- Optimal replica count for load distribution
- Efficient resource utilization
- Minimal latency in traffic routing
- Seamless failover capability

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

---
*Developed with ❤️ for modern deployment practices*



# 🚀 Kubernetes Infrastructure Automation with Terraform

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)
![Helm](https://img.shields.io/badge/helm-%230F1689.svg?style=for-the-badge&logo=helm&logoColor=white)

## 🎯 Project Overview

This enterprise-grade project showcases advanced infrastructure automation using Terraform and Kubernetes. It implements a sophisticated microservices architecture with intelligent traffic distribution powered by NGINX Ingress Controller, demonstrating expertise in modern DevOps practices.

## 🏗️ Technical Architecture

### Core Components

- **🔄 Kubernetes Cluster**: Local development environment using Minikube
- **📦 Application Deployments**: Microservices utilizing hashicorp/http-echo
- **🌐 Service Layer**: Kubernetes internal networking
- **🚦 Ingress Controller**: Advanced traffic management with NGINX
- **⚙️ Infrastructure as Code**: Terraform automation

### Project Structure

```
terraform/
├── applications.json          # Application configurations
├── main.tf                   # Main Terraform configuration
├── modules/
│   └── kubernetes_app/       # Reusable Kubernetes module
│       ├── main.tf          # Module resources
│       ├── outputs.tf       # Module outputs
│       └── variables.tf     # Module variables
└── terraform.tfstate         # Terraform state file
```

## 💻 Technical Implementation

### 1. Provider Configuration

```hcl
# Core providers for infrastructure management
provider "kubernetes" {
  # Kubernetes provider configuration
}

provider "helm" {
  # Helm provider for NGINX Ingress
}

provider "time" {
  # Time provider for deployment orchestration
}
```

### 2. Traffic Distribution Matrix

| Service | Traffic Weight | Purpose |
|---------|---------------|----------|
| foo     | 25%          | Primary service |
| bar     | 25%          | Secondary service |
| boom    | 50%          | Main traffic handler |

## 🚀 Deployment Guide

### Prerequisites

- ✅ Minikube
- ✅ kubectl
- ✅ Terraform
- ✅ Helm

### Deployment Process

1. **Initialize Infrastructure**
   ```bash
   terraform init
   ```

2. **Deploy Resources**
   ```bash
   terraform apply
   ```

3. **Validate Deployment**
   ```bash
   kubectl get pods,svc,ingress
   ```

## 🔧 Troubleshooting Guide

### Common Issues & Solutions

#### 1. Pod CrashLoopBackOff
- **🔍 Symptom**: Repeated pod crashes
- **🛠️ Solution**: Verify container configurations
- **✅ Fix**: Update applications.json arguments

#### 2. Ingress Controller Conflicts
- **🔍 Symptom**: IngressClass existence error
- **🛠️ Solution**: Execute cleanup
  ```bash
  kubectl delete ingressclass nginx
  kubectl delete namespace ingress-nginx
  ```

#### 3. Webhook Validation Errors
- **🔍 Symptom**: Webhook calling failures
- **🛠️ Solution**: Implement readiness delays
- **✅ Fix**: Terraform time_sleep resource

### Verification Commands
```bash
# Health check commands
kubectl get pods -n ingress-nginx
kubectl get pods
kubectl get ingress
kubectl get svc
```

## 🏆 Technical Achievements

### 1. Infrastructure Automation
- ✅ Complete infrastructure as code implementation
- ✅ Modular Terraform architecture
- ✅ Dependency management

### 2. Kubernetes Excellence
- ✅ Microservices deployment
- ✅ Advanced networking
- ✅ Traffic management

### 3. Problem-Solving
- ✅ Webhook timing resolution
- ✅ Resource management
- ✅ Module reusability

## 🔮 Future Roadmap

### 1. Monitoring Enhancement
- 📊 Prometheus integration
- 📈 Grafana dashboards
- 🔍 Advanced metrics

### 2. Security Fortification
- 🔒 Network policies
- 🔐 SSL/TLS implementation
- 👤 Access control

### 3. Scalability Optimization
- 📈 Horizontal pod autoscaling
- 🎯 Resource optimization
- 💪 Performance tuning

## 🎓 Skills Demonstrated

- 🔧 Infrastructure Automation
- 🎯 Container Orchestration
- 💡 Strategic Problem-Solving
- 🚀 Modern DevOps Practices
- 📝 Technical Documentation

## 🤝 Contributing

We welcome contributions! Please follow these steps:
1. Fork the repository
2. Create your feature branch
3. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---
*Built with 💻 and ☕ by Infrastructure Engineering Team*


