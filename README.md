# AWS Infrastructure Automation with Terraform

A modular Terraform project that provisions a production-ready AWS infrastructure following Infrastructure as Code (IaC) best practices. The project also includes a GitHub Actions Continuous Integration (CI) pipeline to automatically validate and verify the Terraform configuration.

---

## Architecture

This project provisions the following AWS resources:

- Amazon VPC
- Public and Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables and Route Table Associations
- Security Groups
- Bastion Host (EC2)
- Private EC2 Application Server
- Application Load Balancer (ALB)
- Target Group and Listener
- Amazon RDS (MySQL)
- SSH Key Pair

The infrastructure is organized into reusable Terraform modules, making it easy to maintain and extend.


---

# Project Structure

```text
terraform/
│
├── modules/
│   ├── alb/
│   ├── ec2/
│   ├── key_pair/
│   ├── rds/
│   ├── security_group/
│   └── vpc/
│
├── main.tf
├── variables.tf
└── terraform.tfvars
```

Each module is self-contained and reusable.

---

# Modules

## VPC

Creates:

- VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Route Table Associations

---

## Security Group

Creates security groups for:

- Application Load Balancer
- Bastion Host
- EC2 Application Server
- Amazon RDS

---

## EC2

Creates:

- Bastion Host
- Private EC2 Application Server

Supports:

- Custom AMI
- Instance Type
- Security Groups
- SSH Key Pair

---

## Key Pair

Creates an SSH key pair for EC2 access.

---

## Application Load Balancer

Creates:

- Application Load Balancer
- Target Group
- Listener
- Target Group Attachments

Supports:

- HTTP
- HTTPS (Optional)

---

## Amazon RDS

Creates:

- Database Instance
- DB Subnet Group
- Parameter Group

---

# Prerequisites

- Terraform >= 1.5
- AWS CLI
- AWS Account
- Git
- GitHub Account

---

# Configure AWS Credentials

```bash
aws configure
```

---

# Deployment

Initialize Terraform:

```bash
terraform init
```

Validate the configuration:

```bash
terraform validate
```

Preview infrastructure changes:

```bash
terraform plan
```

Provision the infrastructure:

```bash
terraform apply
```

Destroy all resources:

```bash
terraform destroy
```

---

# Continuous Integration (CI)

This project includes a **GitHub Actions CI/CD** workflow that allows users to manually execute Terraform operations directly from the GitHub Actions interface.

### Available Commands

When manually running the workflow, you can select one of the following commands:

* **plan** – Generates and displays the Terraform execution plan without making any changes.
* **apply** – Creates or updates the AWS infrastructure defined in the Terraform configuration.
* **destroy** – Removes all Terraform-managed infrastructure from AWS.

## Pipeline Steps

The workflow performs the following steps:

1. Checkout the repository.
2. Configure AWS credentials using GitHub Secrets.
3. Set up the Terraform CLI.
4. Run `terraform fmt -check -recursive` to verify code formatting.
5. Run `terraform init` to initialize the Terraform working directory.
6. Run `terraform validate` to validate the Terraform configuration.
7. Execute the selected Terraform command (`plan`, `apply`, or `destroy`).

This workflow provides a simple and controlled way to manage AWS infrastructure by allowing operators to choose the desired Terraform action at runtime while ensuring the configuration is properly formatted and validated before execution.


---

# Technologies

- Terraform
- AWS VPC
- Amazon EC2
- Amazon RDS
- Application Load Balancer (ALB)
- GitHub Actions
- AWS CLI
- SSH

---

# Features

- Modular Terraform architecture
- Reusable infrastructure modules
- Production-ready VPC networking
- Public and Private Subnets
- NAT Gateway
- Bastion Host
- Application Load Balancer
- Private EC2 Application Server
- Amazon RDS (MySQL)
- Automatic SSH Key Pair creation
- Infrastructure as Code (IaC)
- Automated Continuous Integration using GitHub Actions
- Terraform formatting, validation, and planning
