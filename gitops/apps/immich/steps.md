https://www.frankzhao.com.au/Kubernetes/Immich

0. Consists of the following
   |- Chart.yaml
   |- values.yaml
   |- templates
   |- postgres.yaml (using CloudnativePG operator)
   |- seecret-postgres.yaml  
    |- storage.yaml (pv and pvcs)

1. Create cnpg operator in server
   helm repo add cnpg https://cloudnative-pg.github.io/charts
   helm repo update
   helm install cnpg \
    --namespace cnpg-system \
    --create-namespace \
    cnpg/cloudnative-pg

2.
