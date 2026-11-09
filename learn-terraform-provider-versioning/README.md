# Learn Terraform Provider Versioning

This repo is a companion repo to the [Lock and Upgrade Provider Versions tutorial](https://developer.hashicorp.com/terraform/tutorials/configuration-language/provider-versioning), containing Terraform configuration files to provision a S3 bucket.

## Provider upgrade exercise

The starting lock file selected AWS provider 4.5.0. After the upgrade, the
lock file selected AWS provider 6.72.0. Both versions satisfy the
`>= 4.5.0` constraint. The Random provider stayed at 3.1.0 because its
configuration pins that exact version.

Use `terraform init -lockfile=readonly` to reproduce the provider selections
in this snapshot. When intentionally upgrading, run `terraform init -upgrade`,
review the changes to `.terraform.lock.hcl`, validate the configuration, and
review a fresh plan. Review provider upgrade notes when a selection crosses
major versions.

The lab used the AWS London region (`eu-west-2`) and HCP Terraform for planning.
For remote execution, configure your own HCP organization, workspace, and
provider credentials. See the [variables lesson](../learn-terraform-variables/README.md)
for HCP AWS OIDC setup.

## Saved plan evidence

The [initial plan](../plan-reports/provider-versioning-initial.json) proposed
creating an S3 bucket and a random name. The
[upgrade](../plan-reports/provider-versioning-upgrade.json) and
[final](../plan-reports/provider-versioning-final.json) plans proposed no
resource changes. Terraform reported an S3 bucket drift entry in both, which
the reports list separately from planned actions. These reports describe
plans and drift observations rather than apply results.

[Lock and upgrade provider versions](https://developer.hashicorp.com/terraform/tutorials/configuration-language/provider-versioning) ·
[Dependency lock file](https://developer.hashicorp.com/terraform/language/files/dependency-lock)
