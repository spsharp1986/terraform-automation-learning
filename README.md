# terraform-automation-learning

Terraform course exercises:

- [AWS getting started](aws-getting-started/README.md)
- [Initialize Terraform](learn-terraform-init/README.md) — [export notes](learn-terraform-init/EXPORT-NOTES.md)
- [Create a Terraform plan](learn-terraform-plan/README.md) — [export notes](learn-terraform-plan/EXPORT-NOTES.md)
- [Apply Terraform configuration](learn-terraform-apply/README.md)
- [Troubleshoot Terraform](learn-terraform-troubleshooting/README.md)
- [Use Terraform input variables](learn-terraform-variables/README.md)
- [Use Terraform outputs and an RDS-managed password](learn-terraform-outputs/README.md)
- [Manage Terraform and provider versions](learn-terraform-versions/README.md)

The init and plan folders are sanitized learning snapshots. Use a separate HCP Terraform workspace and replace any placeholder settings before running the exercises. Keep credentials, local variable values, state, saved plans, and JSON plan exports out of Git.

[Redacted plan reports](plan-reports/README.md) record the planned resource actions and output changes from the exercises.

Practical Terraform learning projects, with their validation results and limitations documented.

- [AWS getting started](aws-getting-started/README.md): EC2/VPC fundamentals, variables, modules and HCP Terraform.
- Secure media lifecycle framework: a modular Terraform reconstruction of the secure media storage, processing and delivery architecture I originally designed for an online education client. The framework is currently stored separately. Optional stages are disabled by default; this implementation has not been live-deployed.
