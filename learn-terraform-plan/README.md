# Create a Terraform Plan

This repo is a companion repo to the [Create a Terraform Plan](https://developer.hashicorp.com/terraform/tutorials/cli/plan) tutorial.
It contains Terraform configuration you can use to learn how Terraform generates an execution plan.

## Save and inspect a plan

Set required inputs before planning. For a CLI run, put lab values in a local
`dev.tfvars` file and pass it explicitly. See the
[variables lesson](../learn-terraform-variables/README.md) for automatic
loading and HCP workspace variables.

```bash
terraform plan -var-file=dev.tfvars -out=review.tfplan
terraform show review.tfplan
# Apply only after reviewing and approving the changes.
terraform apply review.tfplan
```

The saved plan captures the input values used when planning. Create a new plan
if the inputs change or the plan becomes stale. Local saved plans and JSON
exports can expose sensitive values. In a CLI-driven HCP remote workspace,
Terraform CLI 1.6+ saves a reference to the remote run and needs authenticated
workspace access to inspect or apply it. Keep both kinds of plan file and any
JSON exports out of Git.

[Terraform plan reference](https://developer.hashicorp.com/terraform/cli/commands/plan) ·
[HCP Terraform CLI-driven runs](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/cli)
