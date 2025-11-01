# Project Structure

```
azure/
├── versions.tf              # Provider and Terraform version constraints
├── variables.tf             # All variable definitions
├── main.tf                  # Main resources (ready to use)
├── outputs.tf               # Output definitions
├── terraform.tfvars.example # Example variable values
├── .gitignore              # Git ignore file
├── README.md               # Usage documentation
│
├── main-with-modules.tf.example    # Example using modules
├── outputs-with-modules.tf.example # Example outputs for modules
│
└── modules/                # Reusable modules
    └── storage/            # Storage module example
        ├── versions.tf     # Module version constraints
        ├── variables.tf    # Module inputs
        ├── main.tf         # Module resources
        └── outputs.tf      # Module outputs
```

## Two Deployment Approaches

### 1. Simple Deployment (Current setup)
- Uses `main.tf` directly
- All resources defined inline
- Good for small deployments
- **This is ready to use now**

```bash
terraform init
terraform plan
terraform apply
```

### 2. Modular Deployment (Advanced)
- Rename `main-with-modules.tf.example` → `main.tf`
- Rename `outputs-with-modules.tf.example` → `outputs.tf`
- Uses `modules/` for reusable components
- Better for large, complex deployments

## Version Constraints

### Provider Constraints (versions.tf)
```hcl
azurerm = {
  source  = "hashicorp/azurerm"
  version = "~> 3.80"  # Allows 3.80.x but not 4.x
}
```

### Module Constraints (when using modules)
```hcl
module "storage" {
  source  = "./modules/storage"
  version = "~> 1.0"  # Use with Terraform Registry or git tags
  ...
}
```

## Adding New Modules

Create new modules following this pattern:

```
modules/
└── your-module/
    ├── versions.tf   # Required providers and versions
    ├── variables.tf  # Input variables
    ├── main.tf       # Resources
    └── outputs.tf    # Outputs
```

Then use in main.tf:
```hcl
module "your_module" {
  source = "./modules/your-module"
  # version = "~> 1.0"  # Optional: use with versioned sources
  
  # Input variables
  name     = "example"
  location = var.location
}
```

## Free Services Deployed

✅ Resource Group
✅ Storage Account (5GB free tier)
✅ App Service (F1 free tier - 60min/day)
✅ Static Web App (100GB bandwidth/month)

❌ AKS is NOT free (nodes cost money, ~$30-40/month minimum)

