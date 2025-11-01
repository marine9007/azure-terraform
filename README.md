# Azure Free Tier Terraform Deployment

This Terraform configuration deploys free-tier Azure services.

## Free Services Included

- **Resource Group**: Free
- **Storage Account**: 5GB blob + 5GB file storage free, includes static website hosting
- **App Service Plan (F1)**: 1GB disk, 1GB RAM, 60 min/day compute - FREE
- **App Service**: Linux web app on F1 tier - FREE
- **Static Web App**: 100GB bandwidth/month, custom domain, SSL - FREE

## AKS Note

**AKS is NOT free** - while the control plane is free, you must pay for worker node VMs. Even the cheapest B2s VM costs ~$30-40/month. Only use AKS if you have Azure credits or free trial.

## Prerequisites

1. [Terraform](https://www.terraform.io/downloads.html) >= 1.5.0
2. [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
3. Azure subscription

## Setup

1. Login to Azure:
```bash
az login
```

2. Set your subscription (if you have multiple):
```bash
az account set --subscription "your-subscription-name"
```

3. Copy the example tfvars:
```bash
cp terraform.tfvars.example terraform.tfvars
```

4. Edit `terraform.tfvars` with your values

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
- Storage account name and static website URL
- App Service URL
- Static Web App URL
- Connection strings (sensitive)

View outputs:
```bash
terraform output
terraform output -json
terraform output storage_static_website_url
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

## Cost Warnings

Free tier limits:
- Storage: First 5GB free, then costs apply
- App Service F1: 60 min/day compute, after that app stops
- Static Web App: 100GB bandwidth/month, then costs apply

Always monitor your Azure costs in the portal!

