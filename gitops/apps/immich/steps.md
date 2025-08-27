https://www.frankzhao.com.au/Kubernetes/Immich

0. Consists of
- 


1. Create cnpg operator
helm repo add cnpg https://cloudnative-pg.github.io/charts
helm repo update
helm install cnpg \
  --namespace cnpg-system \
  --create-namespace \
  cnpg/cloudnative-pg

2.