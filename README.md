# Homelab

I pile all my deployments in this kitchen sink of a homelab.

This is my personal playground for infrastructure experiments and self-hosted projects. If I want to learn it, break it, or over-engineer it - it goes in the sink where it will (eventually) be cleaned up and ready to be used.



## Hardware

- **Machine**: Lenovo ThinkCentre (i5-7th Gen)
- **RAM**: 8GB
- **Storage**: 256GB SSD
- **OS**: Ubuntu 22.04.2 LTS
- **IP Address**: dynamic

## Infrastructure

- **Kubernetes**: K3S
- **GitOps**: ArgoCD
- **Networking**: Tailscale, Cloudflared
- **DNS/CDN**: Cloudflare

## Deployed Applications

### ✅ Currently Running

- **Immich** - Photo and video backup solution
  - Database: PostgreSQL
  - Storage: Persistent Volume Claims

### 🚧 In Progress / Planned Deployments

| Application | Status | Purpose |
|---|---|---|
| Jellyfin | Ready | Media server (music, movies, TV) |
| JellySeerr | Ready | Jellyfin request management UI |
| Tailscale | Ready | Secure mesh VPN networking |
| Cloudflared | Ready | Cloudflare tunnel for remote access |
| Sonarr | Planned | Automated TV series downloading |
| Radarr | Planned | Automated movie downloading |
| Lidarr | Planned | Automated music downloading |
| Prowlarr | Planned | Indexer manager for Sonarr/Radarr/Lidarr |

## Project Structure

```
kitchen-sink/
├── gitops/                          # GitOps configuration
│   ├── apps/                        # Application Helm charts managed by ArgoCD
│   │   ├── cloudflared/             # Cloudflare tunnel
│   │   ├── immich/                  # Photo backup (DEPLOYED)
│   │   ├── jellyfin/                # Media server
│   │   ├── jellyseerr/              # Jellyfin request UI
│   │   └── tailscale/               # VPN mesh networking
│   │
│   └── argocd/                      # ArgoCD configuration and self-management
│       ├── argocd-appProjects/      # AppProject definitions (grouping apps)
│       │   ├── media-appProject.yaml
│       │   ├── networking-appProject.yaml
│       │   └── storage-appProject.yaml
│       │
│       ├── argocd-apps/             # ArgoCD Application CR definitions
│       │   ├── cloudflared-app.yaml
│       │   ├── immich-app.yaml
│       │   ├── jellyfin-app.yaml
│       │   ├── jellyseerr-app.yaml
│       │   └── tailscale-app.yaml
│       │
│       └── base/                    # ArgoCD Helm chart for installation
│           ├── Chart.yaml
│           ├── values.yaml
│           └── templates/
│               └── ingress.yaml
│
└── infrastructure/                  # Infrastructure as Code (Terraform)
    ├── argocd/                      # ArgoCD cluster setup
    │   ├── main.tf
    │   ├── namespace.tf
    │   ├── provider.tf
    │   ├── variables.tf
    │   └── values.yaml
    │
    └── argocd-config/               # ArgoCD configuration
        ├── main.tf
        ├── data.tf
        ├── provider.tf
        └── variables.tf
```

## Getting Started

### Prerequisites
- Ubuntu 22.04.2 LTS installed on the ThinkCentre
- Network connectivity to the machine

### Setup Instructions

Detailed setup steps are available in [steps.md](./steps.md), which covers:
1. Ubuntu installation
2. K3S cluster setup
3. ArgoCD installation and configuration
4. Tailscale mesh VPN setup
5. Cloudflare tunnel exposure

### Quick Access

- **ArgoCD UI**: `http://10.0.0.200:<NODEPORT>`
- **SSH via Tailscale**: Use Tailscale IP when connected to mesh VPN

## Deployment Workflow

This project uses ArgoCD for continuous deployment from this Git repository:

1. **Define Application**: Create/update Helm chart in `gitops/apps/<app-name>`
2. **Create AppProject** (if new category): Add to `gitops/argocd/argocd-appProjects/`
3. **Create Application CR**: Add to `gitops/argocd/argocd-apps/<app-name>-app.yaml`
4. **Push to Git**: Commit changes to trigger ArgoCD sync
5. **Monitor**: View deployment status in ArgoCD console

## Configuration

### ArgoCD

- Exposed via NodePort for local access
- Managed through Helm charts in `infrastructure/`
- Applications auto-sync from Git repository

### Storage

- Persistent volumes configured for services requiring data persistence
- Immich uses PostgreSQL for database and PVCs for storage

### Networking

- **Internal**: K3S service network
- **Local**: Static IP 10.0.0.200
- **VPN**: Tailscale mesh networking
- **Remote**: Cloudflare tunnel via Cloudflared

## Next Steps

- [ ] Deploy Jellyfin
- [ ] Deploy JellySeerr
- [ ] Deploy Tailscale
- [ ] Deploy Cloudflared
- [ ] Setup SONAR stack (Sonarr, Radarr, Lidarr, Prowlarr)
- [ ] Configure persistent storage for media
- [ ] Setup monitoring/observability (Prometheus, Grafana - optional)

## Files Reference

- `README.md` - This file
- `steps.md` - Detailed setup and deployment instructions
- `gitops/` - All application deployments and ArgoCD configuration
- `infrastructure/` - Terraform configuration for cluster setup

## Notes

- K3S is a lightweight Kubernetes distribution ideal for resource-constrained environments
- ArgoCD provides GitOps-based continuous deployment
- All application manifests are version-controlled in this repository
