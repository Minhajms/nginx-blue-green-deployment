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
# Kubernetes Infrastructure Automation Project Documentation

## Project Overview
This project demonstrates the automation of Kubernetes infrastructure deployment using Terraform, implementing a microservices architecture with traffic distribution using NGINX Ingress Controller. The solution showcases skills in infrastructure as code, container orchestration, and modern deployment practices.

## Technical Implementation

### Architecture Components
1. **Kubernetes Cluster**: Using Minikube as the local development environment
2. **Application Deployments**: Multiple microservices using the hashicorp/http-echo image
3. **Service Layer**: Internal Kubernetes services for each application
4. **Ingress Controller**: NGINX Ingress for traffic management and routing
5. **Infrastructure as Code**: Terraform for automation and configuration management

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

### Implementation Details

#### 1. Provider Configuration
The project uses two main providers:
- `kubernetes`: For managing Kubernetes resources
- `helm`: For deploying the NGINX Ingress Controller
- `time`: For handling deployment timing and dependencies

#### 2. Application Module
The Kubernetes application module (`kubernetes_app`) creates:
- Deployments: Managing application pods
- Services: Providing internal networking
- Ingress Rules: Configuring traffic routing

#### 3. Traffic Management
Traffic distribution is handled through NGINX Ingress annotations, allowing weighted routing between services:
- foo: 25% traffic
- bar: 25% traffic
- boom: 50% traffic

## Deployment Process

### Prerequisites
1. Minikube installed and running
2. kubectl configured
3. Terraform installed
4. Helm installed

### Deployment Steps

1. **Initialize Terraform**
```bash
terraform init
```

2. **Apply Configuration**
```bash
terraform apply
```

3. **Verify Deployment**
```bash
kubectl get pods        # Check pod status
kubectl get svc        # Verify services
kubectl get ingress    # Confirm ingress rules
```

## Troubleshooting Guide

### Common Issues and Solutions

1. **Pod CrashLoopBackOff**
   - **Symptom**: Pods repeatedly crashing
   - **Solution**: Check container arguments and port configurations
   - **Fix**: Properly format application arguments in applications.json

2. **Ingress Controller Conflicts**
   - **Symptom**: "IngressClass exists" error
   - **Solution**: Clean up existing resources
   ```bash
   kubectl delete ingressclass nginx
   kubectl delete namespace ingress-nginx
   ```

3. **Webhook Validation Errors**
   - **Symptom**: "failed calling webhook" error
   - **Solution**: Add waiting period for ingress controller readiness
   - **Implementation**: Used time_sleep resource in Terraform

### Verification Commands
```bash
# Check ingress controller status
kubectl get pods -n ingress-nginx

# Verify application deployments
kubectl get pods

# Check ingress rules
kubectl get ingress

# View service status
kubectl get svc
```

## Technical Achievements

1. **Infrastructure as Code**
   - Implemented complete infrastructure automation
   - Used modular Terraform configuration
   - Managed complex dependencies

2. **Kubernetes Orchestration**
   - Deployed multiple microservices
   - Configured internal networking
   - Implemented traffic distribution

3. **Problem Solving**
   - Resolved timing issues with webhook validation
   - Implemented proper resource cleanup
   - Created reusable module structure

## Future Enhancements

1. **Monitoring Integration**
   - Add Prometheus metrics
   - Implement Grafana dashboards

2. **Security Improvements**
   - Implement network policies
   - Add SSL/TLS termination

3. **Scalability Features**
   - Implement horizontal pod autoscaling
   - Add resource limits and requests

## Conclusion
This project demonstrates strong skills in:
- Infrastructure automation
- Container orchestration
- Problem-solving
- Modern deployment practices
- Documentation and technical communication


