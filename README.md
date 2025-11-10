# Azure Free Tier Terraform Deployment

This Terraform configuration deploys free-tier Azure services.

## Free Services Included

- **Resource Group**: Free container for all resources
- **Storage Account**: 5GB blob + 5GB file storage free, includes static website hosting
- **Static Web App**: 100GB bandwidth/month, custom domain, SSL - FREE
- **Storage Container**: Private blob container for data storage

## Note on App Service

**App Service (F1) is NOT included** - Pay-as-you-go subscriptions typically block the free F1 tier. If you have Azure for Students or credits, you can uncomment the App Service resources in `main.tf`.

## AKS Note

**AKS is NOT free** - while the control plane is free, you must pay for worker node VMs. Even the cheapest B2s VM costs ~$30-40/month. Only use AKS if you have Azure credits or free trial.

## Prerequisites

1. [Terraform](https://www.terraform.io/downloads.html) >= 1.5.0
2. [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
3. Azure subscription

## Authentication

1. Login to Azure with tenant:
```bash
az login --tenant YOUR_TENANT_ID
```

If you get Graph API scope errors, use:
```bash
az login --scope https://graph.microsoft.com/.default
```

2. Set your subscription (if you have multiple):
```bash
az account set --subscription "your-subscription-id"
```

3. Verify your authentication:
```bash
az account show
```

4. Copy the example tfvars (if it exists):
```bash
cp terraform.tfvars.example terraform.tfvars
```

5. Edit `terraform.tfvars` with your values (or use defaults)

## Usage

```bash
# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply

# Destroy resources when done
terraform destroy
```

## Outputs

After deployment, you'll get:
- **Resource Group**: Name and ID
- **Storage Account**: Name and static website URL
- **Static Web App**: Default hostname and API key
- **Connection Strings**: Storage connection string (sensitive)

View outputs:
```bash
# All outputs
terraform output

# JSON format
terraform output -json

# Specific output
terraform output storage_static_website_url
terraform output static_web_app_default_hostname

# Sensitive values
terraform output static_web_app_api_key
```

## Expanding the Configuration

To add more resources:
1. Define variables in `variables.tf`
2. Add resources in `main.tf` or create new `.tf` files
3. Add outputs in `outputs.tf`

For modular structure, create a `modules/` directory:
```
modules/
├── networking/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── versions.tf
└── compute/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    └── versions.tf
```

## Cost & Limits

**Free tier limits:**
- **Storage Account**: First 5GB blob + 5GB file storage free, then ~$0.018/GB/month
- **Static Web App**: 100GB bandwidth/month free, then costs apply
- **Blob Operations**: First 50,000 operations free

**Zero cost if you stay within limits** - but always monitor your Azure costs in the portal!

## Deploying Content

**To Static Web App:**
```bash
# Get the deployment token
terraform output -raw static_web_app_api_key

# Deploy using SWA CLI or GitHub Actions
npm install -g @azure/static-web-apps-cli
swa deploy --deployment-token="<token>"
```

**To Storage Static Website:**
```bash
# Get storage account name
STORAGE_NAME=$(terraform output -raw storage_account_name)

# Upload files
az storage blob upload-batch \
  --account-name $STORAGE_NAME \
  --destination '$web' \
  --source ./dist
```

## Troubleshooting

**DNS propagation errors:**
If you get "no such host" errors right after deployment, wait 2-3 minutes for DNS propagation.

**Quota errors for App Service:**
Pay-as-you-go subscriptions often block F1 tier. This is expected - use Static Web App or Storage instead.

