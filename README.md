# Terraform Demo - CI/CD Pipeline

> A demonstration of Terraform CI/CD best practices with automated security scanning, tag validation, and plan/apply workflows.

## 🏗️ Pipeline Overview

```
PR Opened → Lint → Security Scan → Tag Validation → Plan (PR Comment)
                                         ↓
PR Merged → Apply (Staging)
```

### Pipeline Stages

| Stage | Tools | Purpose |
|-------|-------|---------|
| **Lint** | `terraform fmt`, `terraform validate` | Syntax & format checks |
| **Security** | tfsec, Checkov | Vulnerability & policy scanning |
| **Tags** | [terraform-tag-validator](https://github.com/olu-folarin/terraform-tag-validator) | Cost allocation compliance |
| **Plan** | `terraform plan` | Change preview as PR comment |
| **Apply** | `terraform apply` | Deploy on merge |

## 🚀 Getting Started

### Prerequisites

- AWS Account
- GitHub repository with Actions enabled
- (Optional) AWS OIDC provider for secure authentication

### 1. Clone & Configure

```bash
git clone https://github.com/YOUR_USERNAME/terraform-demo.git
cd terraform-demo
```

### 2. Configure AWS Authentication

**Option A: OIDC (Recommended)**

1. Create an IAM OIDC identity provider for GitHub Actions
2. Create an IAM role with trust policy for your repo
3. Update `.github/workflows/terraform.yml` with your role ARN

```yaml
- name: Configure AWS Credentials
  uses: aws-actions/configure-aws-credentials@v4
  with:
    role-to-assume: arn:aws:iam::ACCOUNT_ID:role/github-actions-role
    aws-region: eu-west-2
```

**Option B: Access Keys (Not Recommended)**

Add secrets to your repository:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

### 3. Configure Remote State (Optional)

1. Create S3 bucket for state storage
2. Create DynamoDB table for state locking
3. Uncomment backend configuration in `providers.tf`

### 4. Push Changes

```bash
git add .
git commit -m "Initial commit"
git push origin main
```

## 📁 Project Structure

```
terraform-demo/
├── .github/
│   └── workflows/
│       └── terraform.yml    # CI/CD pipeline
├── main.tf                  # Main resources
├── providers.tf             # Provider & backend config
├── variables.tf             # Input variables
├── outputs.tf               # Output values
├── tags-config.yml          # Tag validation rules
└── README.md
```

## 🏷️ Tagging Standard

All resources must have these tags:

| Tag | Description | Example |
|-----|-------------|---------|
| `department` | Owning department | `platform` |
| `service` | Service name | `terraform-demo` |
| `environment` | Environment | `staging` |
| `production` | Is production? | `true` / `false` |
| `contact` | Team contact | `Platform Team: email@example.com` |
| `domain` | Business domain | `infrastructure` |

## 🔒 Security Scanning

### tfsec
Scans for security misconfigurations in Terraform code.

### Checkov
Policy-as-code scanner that checks for:
- AWS best practices
- CIS benchmarks
- SOC2 compliance

## 📋 PR Comments

When you open a PR, you'll receive automated comments:
1. **Lint Results** - Format and validation status
2. **Security Results** - tfsec and Checkov findings
3. **Terraform Plan** - Full plan output

## 🛠️ Local Development

```bash
# Format code
terraform fmt -recursive

# Validate
terraform init -backend=false
terraform validate

# Plan
terraform plan
```

## 📄 License

MIT
