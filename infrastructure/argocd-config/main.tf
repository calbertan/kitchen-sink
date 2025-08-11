resource "argocd_repository" "repo_kitchen-sink" {
  repo = "https://github.com/calbertan/kitchen-sink.git"

  annotations = {
    "argocd.argoproj.io/secret-type" = "repository"
  }

  depends_on = [
    helm_release.argocd
  ]
}
