# Redacted Terraform plan reports

These JSON reports record the Terraform version, resource types, action counts,
and output change metadata from saved plans. Output values are redacted.
Variable values, resource attributes and addresses, configuration, state, and
HCP Terraform run identifiers were omitted. The reports are for review and
cannot be applied.

| Lesson | Report | Planned changes |
| --- | --- | --- |
| Plan | [Initial plan](plan-initial.json) | Create one EC2 instance and three random names |
| Plan | [Input variable change](plan-input-variable.json) | Replace one random name and leave three resources unchanged |
| Outputs | [Initial plan](outputs-initial.json) | Create 49 resources, including an RDS instance |
| Outputs | [Add outputs](outputs-with-values.json) | Create the same 49 resources and add three outputs |
| Outputs | [Sensitive outputs](outputs-sensitive.json) | Create the same 49 resources and add five outputs, two marked sensitive |
| Versions | [Version update](versions-update.json) | Create two resources and add two outputs |
| Provider versioning | [Initial plan](provider-versioning-initial.json) | Create an S3 bucket and a random name |
| Provider versioning | [Upgrade plan](provider-versioning-upgrade.json) | No planned resource changes. One bucket drift entry |
| Provider versioning | [Final plan](provider-versioning-final.json) | No planned resource changes. One bucket drift entry |

The reports consolidate archived copies with the same visible plan structure.
Standalone HCP run references contain pointers to remote runs. They are
excluded, along with the raw local plans and JSON exports.

The historical outputs lesson used a database username and password as
Terraform inputs. The [published outputs lesson](../learn-terraform-outputs/README.md)
uses an RDS-managed master password. These reports document planned changes
and do not record an apply result.

## Resource targeting

| Report | Planned actions |
| --- | --- |
| [Initial](targeting-init.json) | 13 additions |
| [Length update](targeting-length-update.json) | 13 additions |
| [Resource target](targeting-target.json) | One random resource addition |
| [Module target](targeting-target-module.json) | Five additions including the upstream random name |
| [Final full plan](targeting-final.json) | Three object replacements and ten unchanged resources |

## State management

Six [state lesson reports](../learn-terraform-state/README.md#plan-evidence)
cover initial creation, an unchanged follow-up, replacement, a second
configuration, and two plans that proposed an instance deletion.

## Importing a Docker container

- [Initial import plan](import-initial.json)
- [Simplified configuration plan](import-simplified.json)

Both propose one container import with an in-place update.
