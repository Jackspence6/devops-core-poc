# DevOps Core Proof of Concept

🚀 Live Application: http://finance-tracker-alb-2036972499.us-east-1.elb.amazonaws.com

End-to-end DevOps proof of concept showcasing AWS infrastructure provisioning, CI/CD pipelines, containerized application deployment, and managed database integration.

---

## 📑 Table of Contents

1. [IAM (Identity and Access Management)](#%F0%9F%A7%91%F0%9F%91%BB-iam-identity-and-access-management)
2. [ECR (Elastic Container Registry)](#%F0%9F%90%B3-ecr-elastic-container-registry)
3. [ECS (Elastic Container Service)](#%F0%9F%9F%A2-ecs-elastic-container-service)
4. [ALB (Application Load Balancer)](#%F0%9F%8C%90-alb-application-load-balancer)
5. [RDS (PostgreSQL Database)](#%F0%9F%97%84%EF%B8%8F-rds-postgresql-database)
6. [VPC (Virtual Private Cloud)](#%F0%9F%8C%90-vpc-virtual-private-cloud)

---

## 🧑‍💻 IAM (Identity and Access Management)

**Purpose:** Manage users, roles, and permissions for accessing AWS resources.

- **Roles Available:**
  - **Dev Role (`dev-ops-ninja`)** - For local development and Terraform infrastructure provisioning. Full admin permissions.
  - **GitHub Actions Role (`github-actions-role`)** - For CI/CD pipeline access via OIDC.

### IAM Configuration Table

| Role Name               | Purpose                            | Permissions         | Session Expiration | Notes                                 |
| ----------------------- | ---------------------------------- | ------------------- | ------------------ | ------------------------------------- |
| **dev-ops-ninja**       | Local dev + Terraform provisioning | AdministratorAccess | 1 hour             | Assume via AWS CLI, sets local creds  |
| **github-actions-role** | CI/CD pipelines via GitHub Actions | AdministratorAccess | 1 hour             | Trusts GitHub OIDC; used in workflows |

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

## 🐳 ECR (Elastic Container Registry)

**Purpose:** Host Docker container images for ECS deployments.

### How to Use:

```bash
# Authenticate Docker to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 471112820262.dkr.ecr.us-east-1.amazonaws.com

# Build image
docker build -t <APP_NAME> .

# Tag image
docker tag <APP_NAME>:latest <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com/<APP_NAME>:latest

# Push image
docker push <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com/my-app:latest
```

#### Finance Tracker ECR Details

**Repository URL:** 471112820262.dkr.ecr.us-east-1.amazonaws.com/finance-tracker-repository

**Repository ARN:** arn:aws:ecr:us-east-1:471112820262:repository/finance-tracker-repository

## 🟢 ECS (Elastic Container Service)

**Purpose:** Run containerized Next.js app using Fargate.

### Configuration

- **Launch Type:** Fargate
- **Cluster:** `finance-tracker-cluster`
- **Service:** `finance-tracker-cluster`
- **Container Port:** `3000`
- **CPU / Memory:** `0.25 vCPU / 0.5GB`

### Key Notes

- App runs on **port 3000** (Next.js default)
- Security group allows traffic from ALB → ECS on port 3000
- Uses ECR image: `471112820262.dkr.ecr.us-east-1.amazonaws.com/finance-tracker-repository:latest`

### Deployment Flow

1. Push image to ECR
2. Terraform updates task definition
3. ECS service redeploys tasks
4. ALB routes traffic to healthy containers

---

## 🌐 ALB (Application Load Balancer)

**Purpose:** Expose ECS service to the internet.

### Configuration

- **Type:** Internet-facing
- **Listener Port:** `80`
- **Target Group Port:** `3000`
- **Health Check Path:** `/`
- **Health Check Port:** `traffic-port`

### Traffic Flow

User → ALB (port 80) → Target Group → ECS Task (port 3000)

### Important Notes

- 503 errors usually mean:
  - App not running
  - Wrong port
  - Health checks failing
- Target group port **must match** container port

## 🗄️ RDS (PostgreSQL Database)

**Purpose:** Managed relational database for application storage.

- **Instance Name:** `dev-ops-db`
- **Database Engine:** PostgreSQL
- **Connection Info:**
  - Host: `<RDS_ENDPOINT>`
  - Port: `5432`
  - Username: `admin`
  - Password: `yourpassword`

- **Terraform Example Outputs:**

  ```hcl
  terraform output db_endpoint
  terraform output db_port
  ```

- **Connecting via psql:**

  ```bash
  psql -h <RDS_ENDPOINT> -p 5432 -U admin -d postgres
  ```

## 🌐 VPC (Virtual Private Cloud)

**Purpose:** Network layer for all AWS resources — subnets, routing, internet access, and security boundaries.

- **Components:**
  - **Public Subnets:** For internet-facing resources like ALB or NAT Gateway.
  - **Private Subnets:** For ECS tasks, RDS, and other internal services.
  - **Internet Gateway (IGW):** Provides outbound internet access for public subnets.
  - **Route Tables:** Manage traffic flow within the VPC.

- **Terraform Outputs:**

  ```hcl
  terraform output vpc_id           # ID of the VPC
  terraform output public_subnets  # List of public subnet IDs
  terraform output private_subnets # List of private subnet IDs
  ```

### 🌐 VPC Configuration

| Component              | Value / Description                            |
| ---------------------- | ---------------------------------------------- |
| **VPC ID**             | `terraform output vpc_id`                      |
| **CIDR Block**         | `10.0.0.0/16`                                  |
| **Public Subnets**     | `10.0.1.0/24`, `10.0.2.0/24`                   |
| **Private Subnets**    | `10.0.101.0/24`, `10.0.102.0/24`               |
| **Availability Zones** | `us-east-1a`, `us-east-1b`                     |
| **Internet Gateway**   | Attached to VPC (for public subnet access)     |
| **NAT Gateway**        | ❌ Not deployed                                |
| **Route Tables**       | Public subnets → IGW                           |
| **Tags**               | Project: `devops-core-poc`, Environment: `dev` |

**Notes:**

- Public subnets are mapped to receive public IPs automatically.
- Private subnets currently have **no outbound internet** to stay within free-tier limits.
- NAT Gateway can be added later if private subnets need internet access.

**Additional Notes:**

- All other modules (ECS, RDS) are deployed into this VPC.
