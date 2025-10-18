https://artifacthub.io/packages/helm/community-charts/cloudflared

### Prerequisites

1. Create a Cloudflare Account If you do not yet have a Cloudflare account, please refer to to create one.

2. Set Up a Cloudflared Tunnel If you already have a Cloudflare account and have added your domain to it and run the following commands

   - cloudflared tunnel login
   - cloudflared tunnel create <NAME>
   - cloudflared tunnel list

3. Store Tunnel Files After creating your Cloudflared tunnel via CLI, ensure the following files are stored in the ~/.cloudflared directory under your home directory:
   - Your tunnel credentials JSON file.
   - Your tunnel certificate PEM file.

### Encoding and Configuring Tunnel Files for values.yaml

1. Encode the Tunnel Credentials JSON File Use the following command to obtain the base64-encoded version of your tunnel credentials JSON file and set it in the tunnelSecrets.base64EncodedConfigJsonFile configuration:

   ```
   cat ~/.cloudflared/*.json | base64
   ```

2. Encode the Tunnel Certificate PEM File Use the following command to obtain the base64-encoded version of your tunnel certificate PEM file and set it in the tunnelSecrets.base64EncodedPemFile configuration:

   ```
   cat ~/.cloudflared/cert.pem | base64
   ```

3. Set the Tunnel Name Pass the name of your tunnel, as created earlier via the Cloudflared CLI, to the tunnelConfig.name configuration.

### After deployment

1. Run the following command to create a record that routes to the tunnel
   ```
   cloudflared tunnel route dns <TUNNEL> "<HOSTNAME>"
   ```
