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



https://immich-app.github.io/immich-charts
Failed to load target state: failed to generate manifest for source 1 of 1: rpc error: code = Unknown desc = failed to execute helm template command: failed to get command args to log: `helm template . --name-template immich-app --namespace immich --kube-version 1.32 --values /tmp/f87eb6a6-dec3-420d-9014-aab2ab2e7384/immich/values.yaml <api versions removed> --include-crds` failed exit status 1: Error: execution error at (immich/templates/checks.yaml:1:64): .Values.immich.persistence.library.existingClaim is required. Use --debug flag to render out invalid YAML

oci://ghcr.io/immich-app/immich-charts/immich
oci://ghcr.io/immich-app/immich-charts
Failed to load target state: failed to generate manifest for source 1 of 1: rpc error: code = Unknown desc = error fetching chart: failed to fetch chart: failed to get command args to log: `helm pull --destination /tmp/44913f85-c698-4ff5-8de4-f453c597cfed --version 0.9.3 --repo oci://ghcr.io/immich-app/immich-charts immich` failed exit status 1: Error: looks like "oci://ghcr.io/immich-app/immich-charts" is not a valid chart repository or cannot be reached: object requied