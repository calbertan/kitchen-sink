terraform {
  required_providers {
    argocd = {
      source  = "argoproj/argocd"
      version = ">= 7.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

provider "kubernetes" {
  config_path = "${var.project_root}/.kube/config/k3s.yaml"
  config_context = "default"
}

provider "helm" {
  kubernetes = {
    config_path = "${var.project_root}/.kube/config/k3s.yaml"
    config_context = "default"
  }
}

locals {
  argocd_admin_password = base64decode(
    data.kubernetes_secret.argocd_admin.data["password"]
  )
}

provider "argocd" {
  server_addr = "https://10.0.0.200:30080"
  insecure = "true" 
  username = "admin"
  password = local.argocd_admin_password
}