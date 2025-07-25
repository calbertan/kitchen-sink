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