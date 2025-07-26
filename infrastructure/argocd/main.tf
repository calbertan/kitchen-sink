resource "helm_release" "argocd" {
  name = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"
  namespace = "argocd"
  create_namespace = true
  version = "7.8.4"

  values = [
    file("values.yaml")
  ]

  depends_on = [ 
    kubernetes_namespace.argocd 
  ]
}

resource "argocd_repository" "repo_kitchen-sink" {
  repo = "https://github.com/calbertan/kitchen-sink.git"

  annotations = {
    "argocd.argoproj.io/secret-type" = "repository"
  }

  depends_on = [
    helm_release.argocd
  ]
}

# resource "argocd_application" "root" {

# }