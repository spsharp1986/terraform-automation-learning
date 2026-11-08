# Learn Terraform outputs

This repo is a companion repo to the [Learn Terraform outputs](https://developer.hashicorp.com/terraform/tutorials/configuration-language/outputs) tutorial.
It contains Terraform configuration you can use to learn how Terraform output values allow you to export structured data about your resources.

## Outputs and database credentials

The exercise exports the VPC ID, load balancer URL, web server count, and
database username. When Terraform creates a database using the regular
`password` argument, it sends that credential to the provider. Marking it
`sensitive` redacts routine CLI display. State and local saved plans can still
hold the value, and commands such as `terraform output -raw` or `-json` can
reveal a sensitive root output.

This snapshot sets `manage_master_user_password = true` on the RDS instance.
RDS generates and manages the master password in AWS Secrets Manager.
Terraform can work with secret metadata such as the ARN without reading the
secret value. Avoid fetching the secret contents through a Terraform data
source or returning them as an output. An application should use a dedicated,
least-privilege database user and retrieve its own secret at runtime using a
workload role scoped to that secret.

If an older lab wrote a real password to state or a saved plan, rotate it and
restrict access to those artifacts, including previous state versions.
For services that require a supplied password, check whether the provider
offers a write-only argument and pair it with an ephemeral input where
supported. That requires a compatible Terraform and provider version.

This snapshot uses MySQL 8.4 and 20 GiB of gp3 storage for the standalone lab.
For remote execution, configure your own HCP Terraform workspace before
initializing. See the [variables lesson](../learn-terraform-variables/README.md)
for the CLI workflow and AWS OIDC settings. Provisioning the lab incurs AWS
charges, and the tutorial skips the final RDS snapshot on destruction.

[Terraform sensitive data](https://developer.hashicorp.com/terraform/language/manage-sensitive-data) ·
[RDS-managed master passwords](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) ·
[RDS MySQL versions](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/MySQL.Concepts.VersionMgmt.html) ·
[RDS storage](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html)
