# DevOps Core Proof of Concept

End-to-end DevOps proof of concept showcasing AWS infrastructure provisioning, CI/CD pipelines, containerized application deployment, and managed database integration.

---

## 🛠 AWS IAM Roles

This project uses two main IAM roles for managing access:

### 1. **Dev Role** (`dev-ops-ninja`)

- **Purpose:** For local development and Terraform infrastructure provisioning.
- **Permissions:** AdministratorAccess (full access to AWS resources).
- **Session Expiration:** 1 hour.
- **How to Assume:**

  ```bash
    aws sts assume-role \
      --role-arn arn:aws:iam::<YOUR_ACCOUNT_ID>:role/dev-ops-ninja \
      --role-session-name dev-session \
      --duration-seconds 3600 \
      > /tmp/dev-creds.json
  ```

  ```bash
  export AWS_ACCESS_KEY_ID=$(jq -r '.Credentials.AccessKeyId' /tmp/dev-creds.json)
  export AWS_SECRET_ACCESS_KEY=$(jq -r '.Credentials.SecretAccessKey' /tmp/dev-creds.json)
  export AWS_SESSION_TOKEN=$(jq -r '.Credentials.SessionToken' /tmp/dev-creds.json)
  ```

**Verify your identity with:**

```bash
aws sts get-caller-identity
```

### 2. **GitHub Actions Role** (`github-actions-role`)

- **Purpose:** CI/CD pipelines in GitHub Actions for deploying infrastructure and applications.
- **Permissions:** AdministratorAccess (full access to AWS resources).
- **Trust Policy:** Allows GitHub Actions to assume this role using OIDC.
- **How to Assume (Direct AWS CLI):**

  ```bash
     aws sts assume-role \
       --role-arn arn:aws:iam::<YOUR_ACCOUNT_ID>:role/github-actions-role \
       --role-session-name github-session \
       --duration-seconds 3600 \
       > /tmp/github-creds.json
  ```

  ```bash
     export AWS_ACCESS_KEY_ID=$(jq -r '.Credentials.AccessKeyId' /tmp/github-creds.json)
     export AWS_SECRET_ACCESS_KEY=$(jq -r '.Credentials.SecretAccessKey' /tmp/github-creds.json)
     export AWS_SESSION_TOKEN=$(jq -r '.Credentials.SessionToken' /tmp/github-creds.json)
  ```

**Verify your identity with:**

```bash
   aws sts get-caller-identity
```

## 🧑‍💻 Local Development

To set up your local development environment, follow these steps:

1. **Assume the Dev Role**:

Use the above instructions to assume the `dev-ops-ninja` role and set your AWS credentials in your terminal.

2. **Install Terraform**:

Ensure you have Terraform installed on your machine. You can download it from the [Terraform website](https://www.terraform.io/downloads).

3. **Initialize Terraform**:

Navigate to the `terraform/environments/dev` directory and run `terraform init` to initialize the Terraform configuration.

4. **Plan and Apply**:

Use `terraform plan` to see the changes that will be made, and `terraform apply` to provision the infrastructure.
