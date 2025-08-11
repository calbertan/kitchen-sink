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
