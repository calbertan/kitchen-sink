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

5. Update permissions
mkdir -p ./.kube
sudo cp /etc/rancher/k3s/k3s.yaml ./.kube/config
sudo chown "$USER:$USER" ~/.kube/config
# optional: make kubectl always use it
echo 'export KUBECONFIG=$HOME/.kube/config' >> ~/.bashrc
source ~/.bashrc


ArgoCD
1. patch argocd-service to NodePort to access console
kubectl patch svc argocd-server -n argocd \
  -p '{"spec":{"type":"NodePort"}}'

2. view console at 10.0.0.200/NODEPORT_IP

3. get the password
k -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d; echo 

Tailscale
0. Create a Tailscale account

1. Install tailscale in the server
curl -fsSL https://tailscale.com/install.sh | sh

2. Add server to tailscale account
sudo tailscale up --ssh

3. connect to tailscale


## Immich
https://www.frankzhao.com.au/Kubernetes/Immich


## Folder structure
gitops/
├── apps/                             # workloads managed by ArgoCD
│   ├── tailscale/
│   │   ├── Chart.yaml
│   │   └── values.yaml
│   ├── immich/
│   ├── jellyfin/
│   └── jellyseerr/
│
└── argocd/                           # ArgoCD self-management
    ├── argocd-appProjects/           # grouping of apps
    │   ├── media-project.yaml        # groups jellyfin, immich, jellyseerr
    │   └── networking-project.yaml   # groups tailscale, etc.
    │
    ├── argocd-apps/                  # actual Application CRs
    │   ├── tailscale.yaml
    │   ├── immich.yaml
    │   ├── jellyfin.yaml
    │   └── jellyseerr.yaml
    │
    └── base/                         # ArgoCD installation manifests
        ├── Chart.yaml
        ├── values.yaml
        └── templates/
            └── ingress.yaml          # ingress for the ArgoCD server


