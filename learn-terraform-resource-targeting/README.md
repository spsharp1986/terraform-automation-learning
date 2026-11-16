# Learn Terraform Resource Targeting

This repo is a companion repo to the [Terraform Resource Targeting tutorial](https://developer.hashicorp.com/terraform/tutorials/state/resource-targeting).

It contains Terraform configuration you can use to learn how to implement an S3 bucket and bucket objects with Terraform resource targeting.

## What I covered

- Used a registry S3 module and four indexed object resources with generated names.
- Changed random-name length, object content, and bucket outputs.
- Compared full plans with resource and module targeting. A targeted resource
  plan included one random resource. Module targeting included the bucket
  module and its upstream random name, for five planned additions.
- Returned to a full plan after targeting. The final plan proposed replacing
  three S3 objects while ten resources remained unchanged.

## Saved plan evidence

The five [redacted plan reports](../plan-reports/README.md) preserve resource
types, action counts, and output metadata. The initial and length-update plans
each proposed 13 additions. Reports describe planning results. Run targeting
can omit other configuration changes, so review a full plan afterwards.
Use targeting for exceptional recovery or troubleshooting.

## Reproducing the lab

The published configuration uses London and the committed provider lock file.
Configure your own HCP workspace for remote execution. Run init, validate,
and review a full plan before applying.

This course lab deliberately uses public-read S3 objects and disables bucket
public access blocks. Use disposable, non-sensitive sample content for it.

[Terraform resource targeting](https://developer.hashicorp.com/terraform/tutorials/state/resource-targeting)
