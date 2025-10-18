https://artifacthub.io/packages/helm/community-charts/cloudflared

### Prerequisites

1. Create a Cloudflare Account If you do not yet have a Cloudflare account, please refer to to create one.

2. Set Up a Cloudflared Tunnel If you already have a Cloudflare account and have added your domain to it, follow the first three steps in to create a Cloudflared tunnel using the CLI.

3. Store Tunnel Files After creating your Cloudflared tunnel via CLI, ensure the following files are stored in the ~/.cloudflared directory under your home directory:
   - Your tunnel credentials JSON file.
   - Your tunnel certificate PEM file.
