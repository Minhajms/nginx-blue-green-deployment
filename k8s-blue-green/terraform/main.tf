terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# Install NGINX Ingress Controller
resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  
  set {
    name  = "controller.ingressClassResource.name"
    value = "nginx-custom"
  }

  set {
    name  = "controller.ingressClassResource.enabled"
    value = "true"
  }

  set {
    name  = "controller.ingressClassResource.default"
    value = "true"
  }
}

# Wait for the admission webhook to be ready
resource "time_sleep" "wait_for_ingress" {
  depends_on = [helm_release.nginx_ingress]
  create_duration = "30s"
}

locals {
  applications = jsondecode(file("${path.module}/applications.json"))["applications"]
}

module "kubernetes_apps" {
  source    = "./modules/kubernetes_app"
  for_each  = { for app in local.applications : app.name => app }
  
  name            = each.value.name
  image           = each.value.image
  args            = each.value.args
  port            = each.value.port
  replicas        = each.value.replicas
  traffic_weight  = each.value.traffic_weight
  depends_on      = [time_sleep.wait_for_ingress]
}
