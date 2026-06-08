# Azure Enterprise Landing Zone - Kanettech (Putzmeister)

This repository contains the Infrastructure as Code (IaC) developed in **Terraform** for the automated, secure, and scalable deployment of the Cloud Landing Zone tailored for **Putzmeister's** core services migration.

## 🏗️ Architecture Overview

The design implements a hub-and-spoke ready network topology and governance model aligned with Microsoft Azure's **Cloud Adoption Framework (CAF)** best practices:

* **Governance (FinOps):** Dynamic tag inheritance mapped directly from the Resource Group level to enforce strict cost center tracking and asset auditing.
* **Network Security (SecOps):** Subnet isolation coupled with a dedicated Network Security Group (NSG) applying the principle of least privilege (Restricted inbound flow, explicitly authorizing only secure HTTPS/443 traffic).
* **Enterprise State Management:** Configured a **Remote Backend** leveraging Azure Blob Storage with automatic **State Locking** to ensure data integrity and prevent race conditions in multi-user engineering environments.

## 📁 Repository Structure

* `providers.tf`: Defines the Terraform engine settings, required provider versions (`azurerm`), and the secure Remote Backend configuration.
* `variables.tf`: Centralizes environment parameters (Environment type, Region, Network CIDRs) ensuring code reusability across Dev, QA, and Prod stages.
* `main.tf`: Declares core infrastructure resources (Resource Group, Virtual Network, Subnet, NSG, and Security Associations).
* `outputs.tf`: Structural outputs intended for future orchestration and CI/CD pipeline consumption.

## 🚀 Deployment Workflow

```bash
# Initialize the workspace and connect to the Remote Azure Backend
terraform init -reconfigure

# Validate HCL code syntax and internal semantics
terraform validate

# Generate and review the execution plan
terraform plan

# Apply changes and deploy live resources to the Azure Subscription
terraform apply