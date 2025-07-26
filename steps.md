## UBUNTU setup

Specs:
- ThinkCentre | i5-7th Gen | 8GB RAM | 256gb SSD
- Ubuntu 2nano /etc/system4.04.2 LTS
- Static IP: 10.0.0.200

Steps:
1. Use Balena Etcher to flash usb with the ISO for [Ubuntu server](https://ubuntu.com/download/server).
2. Connect PC to monitor and reapetedly press f12 on startup to enter boot menu
3. 


K3S
1. curl -sfL https://get.k3s.io | sh -

2. No longer use sudo
sudo chmod 644 /etc/rancher/k3s/k3s.yaml

3. add k as alias to ~/.bashrc
alias k='kubectl'

4. get kubeconfig from host, change server IP
scp calbertan@10.0.0.200:/etc/rancher/k3s/k3s.yaml ./.kube
server: https://<your_server>:6443

kitchen-sink/
├── infrastructure/              # All Terraform modules go here
│   ├── argocd/                  # Terraform that targets your k3s cluster
│   │   ├── values.yaml
│   │   └── main.tf              # (Optional) main entrypoint
│   └── terraform.tfstate.d/     # Local or remote state files
│
├── apps/                        # Everything ArgoCD manages (GitOps)
│   ├── infra/                   # Root "App of Apps" ArgoCD app
│   └── media/                   # App: Plex, Jellyfin, etc.
│       └── librephotos/         

├── README.md
└── .gitignore


ArgoCD
1. get the password
k -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d; echo 

2. patch argocd-service to NodePort to access console
kubectl patch svc argocd-server -n argocd \
  -p '{"spec":{"type":"NodePort"}}'

3. view

Infrastructure is not done