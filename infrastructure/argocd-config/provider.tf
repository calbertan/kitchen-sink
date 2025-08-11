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

locals {
  argocd_admin_password = base64decode(
    data.kubernetes_secret.argocd_admin.data["password"]
  )
}

provider "argocd" {
  server_addr = var.argo_url
  insecure = "true" 
  username = "admin"
  password = local.argocd_admin_password
}