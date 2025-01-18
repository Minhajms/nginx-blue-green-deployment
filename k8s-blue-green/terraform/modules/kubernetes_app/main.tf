resource "kubernetes_deployment" "app" {
  metadata {
    name = var.name
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.name
      }
    }

    template {
      metadata {
        labels = {
          app = var.name
        }
      }

      spec {
        container {
          name  = var.name
          image = var.image
          args  = ["-listen=:${var.port}", "-text=${replace(split("-text=", var.args)[1], "\"", "")}"]

          port {
            container_port = var.port
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = var.name
  }

  spec {
    selector = {
      app = var.name
    }

    port {
      port        = var.port
      target_port = var.port
    }

    type = "ClusterIP"
  }
}

# Create Ingress Resource
resource "kubernetes_ingress_v1" "app_ingress" {
  metadata {
    name = "${var.name}-ingress"
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
      "nginx.ingress.kubernetes.io/weight" = var.traffic_weight
    }
  }

  spec {
    ingress_class_name = "nginx-custom"  # Match the name we set in helm_release
    
    rule {
      http {
        path {
          path = "/${var.name}"
          path_type = "Prefix"
          backend {
            service {
              name = var.name
              port {
                number = var.port
              }
            }
          }
        }
      }
    }
  }
}

