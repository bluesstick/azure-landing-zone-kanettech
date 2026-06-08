# Azure Enterprise Landing Zone — Demo (KanetTech)

This repository contains a demonstration project of Infrastructure as Code (IaC)
developed in **Terraform** to deploy a secure and scalable Azure Landing Zone.

The design is **inspired by an on-premise-to-Azure migration I led at Putzmeister
Ibérica**, modernized here using current IaC practices (modular structure, remote
state, policy-driven governance).

## 🏗️ Architecture Overview

The design implements a hub-and-spoke ready network topology and a governance model
aligned with Microsoft Azure's **Cloud Adoption Framework (CAF)** best practices:

* **Governance:** A tagging strategy with inheritance from the Resource Group level
  to support cost center tracking and asset auditing (a foundation for FinOps).
* **Network Security:** Subnet isolation coupled with a dedicated Network Security
  Group (NSG) applying the principle of least privilege — restricted inbound flow,
  explicitly authorizing only secure HTTPS/443 traffic.
* **Remote State Management:** A **remote backend** on Azure Blob Storage with
  **state locking**, ensuring state integrity and preventing race conditions in
  multi-user environments.

## 📁 Repository Structure

* `providers.tf`: Terraform settings, required provider versions (`azurerm`), and
  the remote backend configuration.
* `variables.tf`: Centralized environment parameters (environment, region, network
  CIDRs) for reusability across Dev, QA, and Prod stages.
* `main.tf`: Core infrastructure resources (Resource Group, Virtual Network, Subnet,
  NSG, and security associations).
* `outputs.tf`: Outputs intended for future orchestration and CI/CD consumption.

## 🚀 Deployment Workflow

\`\`\`bash
# Initialize the workspace and connect to the remote Azure backend
terraform init -reconfigure

# Validate HCL syntax and internal semantics
terraform validate

# Generate and review the execution plan
terraform plan

# Apply changes and deploy resources to the Azure subscription
terraform apply
\`\`\`

## 📌 Notes

This is a personal learning/demo project built to practice enterprise-grade IaC
patterns on Azure. It reflects real-world design principles (CAF, least privilege,
remote state) at a foundational scale.