# AWS Infrastructure Lifecycle with Terraform

A practical project based on HashiCorp’s AWS Getting Started tutorials,
adapted to deploy in the London region (eu-west-2).

## Purpose

Demonstrate Terraform configuration, reusable modules, remote state,
remote execution and infrastructure lifecycle management.

## Infrastructure

- One Ubuntu EC2 instance, with its type and name supplied through variables.
- A VPC using the 10.0.0.0/16 address range.
- Two private subnets across eu-west-2a and eu-west-2b.
- One public subnet in eu-west-2a.
- An internet gateway, route tables and subnet associations.
- An output exposing the instance’s private DNS name.

The EC2 instance is placed in the first private subnet.

## Tools and dependencies

- Terraform CLI.
- AWS provider 5.100.0, recorded in .terraform.lock.hcl.
- terraform-aws-modules/vpc/aws module 5.19.0.
- HCP Terraform for remote execution and state storage.
- Git and GitHub for version control.

## Workflow

1. Configure AWS credentials as sensitive environment variables in HCP Terraform.
2. Update the cloud block in terraform.tf to reference your own HCP organisation,
   project and workspace.
3. Run terraform init.
4. Run terraform fmt -check and terraform validate.
5. Run terraform plan and review the proposed changes.
6. Run terraform apply when ready to provision resources.
7. Run terraform destroy when the training resources are no longer needed.

Use a separate HCP workspace for an independent deployment. Connecting to an
existing workspace means working with that workspace’s existing state.

## Verification

On 24 October 2026:

- Initialisation succeeded from a fresh GitHub clone.
- Terraform validation passed.
- Terraform formatting was applied and committed.
- An HCP Terraform remote plan completed successfully:
  16 to add, 0 to change, 0 to destroy.
- The formatting changes were pushed to GitHub.

The final verification was a plan only; it did not provision resources.

## Design decisions and limitations

The instance is in a private subnet. The internet gateway serves the public
subnet; it does not give the private instance direct internet access.

No NAT gateway is configured. The private instance therefore has no general
outbound internet route through a NAT gateway.

This exercise uses the module’s default security group. It does not demonstrate
a purpose-built application security policy.

This is a training environment. It does not provide a highly available
application, production monitoring or a tested backup and recovery design.

## Credentials, state and costs

Credentials, state files, saved plans and downloaded providers are excluded
from version control. The provider lock file is committed.

Running EC2 instances and their EBS storage can incur charges. Review the
destroy plan and remove training resources after use. Revoking credentials
does not remove resources or stop their charges.

## Attribution

Adapted from:
https://developer.hashicorp.com/terraform/tutorials/aws-get-started

My adaptations include the London region and availability zones, HCP Terraform
integration, repository organisation and documented verification.